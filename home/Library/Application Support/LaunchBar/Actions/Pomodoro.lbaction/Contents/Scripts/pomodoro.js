/**
 * A pomodoro timer for LaunchBar
 *
 * Set a pomodoro for 15 minutes, and at then end of the interval a large
 * message is displayed along with a notification sound letting you know your
 * pomodoro is done. Go take that five minute break!
 *
 * You can specify differnt times for individual pomodoro sessions. You can also
 * have your own pomodoro message displayed at the end of the interval. Or you
 * can run with the default interval and message and just hit `Start`.
 *
 *   `pomodoro ⌘↩︎`                     - Start a pomodoro
 *   `pomodoro ␣ 17min`                - Start a 17 minute pomodoro
 *   `pomodoro ␣ write the readme 25m` - Start a 25 minute pomodoro aimed at writing the README file
 *
 * ## Defaults
 *
 * The defaults are configurable through the `pomodoro` action itself. The
 * "bang" syntax is used to tell Launchodoro that you are setting a default
 * value. You have three defaults to configure.
 *
 *   `pomodoro ␣ !interval 25min`                 - Set the default pomodoro interval to 25 minutes
 *   `pomodoro ␣ !message Your pomodoro is done!` - Set the default completion message
 *   `pomodoro ␣ !sound Purr`                     - Set the default sound to Purr
 *
 * You can also set the sound by pulling up pomodoro, hit enter, select `Sound`,
 * hit space, and then you can choose one of the listed sounds
 *
 *   `pomodoro ↩︎ Sound ␣`
 */

var SOUND_PATH='/System/Library/Sounds';
var INTERVAL_RGXP=/((?:[1-9][0-9]*(?:h|m(?:in)?|s(?:ec)?)\s*)+)$/;

/**
 * This is the default function called by LaunchBar. If the user just runs the
 * action without any argument, or there is an argument but none of the more
 * specific function are implemented, this function will be called.
 *
 * It is recommended that every default script implements this function.
 *
 * @param {String|Object} argument - The argument, if the action was run with one.
 * @returns {Array|null} List of result Objects to display [https://developer.obdev.at/launchbar-developer-documentation/#/script-output]
 */
function run(argument) {
  if (typeof argument === 'string' || argument instanceof String) {
    runWithString(argument);

  } else if (argument == undefined) {
    var prefs = getPreferences();

    // running via Cmd-Enter ⌘↩︎ will show the pomodoro settings
    if (LaunchBar.options.commandKey == 1) {
      return [
        {title: 'History', icon: 'font-awesome:history', badge: prefs.history.length.toString(), children: getHistory()},
        {title: 'Interval', icon: 'font-awesome:clock-o', badge: prefs.interval},
        {title: 'Message', icon: 'font-awesome:comment', badge: prefs.message},
        {title: 'Sound', icon: 'font-awesome:volume-up', badge: prefs.sound, action: 'playSound', actionArgument: prefs.sound, actionRunsInBackground: true, children: getSounds()}
      ];

    // just pressing Enter ↩︎ executes the default pomodoro
    } else {
      runWithString(prefs.message);
    }
  }
}

/**
 * This function is called by LaunchBar when the user passes text to the action,
 * either by using text input or by using Send To. If your action supports
 * suggestions or live feedback, this function will be called during text input.
 *
 * @param {String} string - The string argument.
 * @returns {Array|null} List of result Objects to display [https://developer.obdev.at/launchbar-developer-documentation/#/script-output]
 */
function runWithString(string) {
  var input = parseInput(string);

  if (input.command != null) {
    switch (input.command) {
      case 'interval':
        setDefaultInterval(input.value);
        break;
      case 'sound':
        setDefaultSound(input.value);
        break;
      case 'message':
        setDefaultMessage(input.value);
        break;
      default:
        LaunchBar.alert('Unknown default setting', 'The setting "'+input.command+'" does not exist');
        return;
    }
  } else {
    LaunchBar.displayInLargeType({
      title: '🍅 Pomodoro',
      string: input.message,
      sound:  input.sound,
      delay:  input.interval
    });
    addToHistory(string);
  }
}

/**
 * Accessor to the preferences object. Sensible defaults are configured if this
 * is the very first time the method is called.
 *
 * @returns {Object} The preferences object
 */
function getPreferences() {
  var prefs = Action.preferences;

  if (!prefs.hasOwnProperty('interval')) prefs.interval = '15min';
  if (!prefs.hasOwnProperty('sound'))    prefs.sound    = 'Glass';
  if (!prefs.hasOwnProperty('message'))  prefs.message  = 'Your pomodoro is done!';
  if (!prefs.hasOwnProperty('history'))  prefs.history  = [];

  return prefs;
}

/**
 * Parse the given string input and return an input Object containing the parsed
 * information. The input Object is filled with default values if the input
 * string did not otherwise contain a value for a particular input. For example,
 * if the input string does not contain an `interval`, then the default interval
 * will be used.
 *
 * @param {String} string - The input string typed in by the user
 * @returns {Object} An object containing the parsed information
 */
function parseInput(string) {
  var prefs = getPreferences();
  var input = {
    command:  null,
    value:    null,
    interval: prefs.interval,
    sound:    prefs.sound,
    message:  prefs.message
  };

  // parse a command string to set a default value
  if (string.charAt(0) == '!') {
    var parts = string.split(' ');
    var command = parts.shift();
    input.command = command.slice(1);
    input.value   = parts.join(' ');

  // otherwise parse out a regular pomodoro session
  } else {
    var message = string.replace(INTERVAL_RGXP, "").trim();
    var interval = RegExp.$1;

    if (message.length > 0) input.message = message;
    if (interval) input.interval = interval.trim();
  }

  return input;
}

/**
 * Set the default interval. Display an alert to the user if the interval does
 * not conform to the expected format.
 *
 * @param {String} interval - The new default pomodoro interval
 * @returns undefined
 */
function setDefaultInterval(interval) {
  if (INTERVAL_RGXP.test(interval)) {
    setDefault('interval', interval);
  } else {
    LaunchBar.alert('Invalid interval', 'The value "'+interval+'" was not recognized as a valid interval');
  }
}

/**
 * Set the default message.
 *
 * @param {String} message - The new default message
 * @returns undefined
 */
function setDefaultMessage(message) {
  setDefault('message', message);
}

/**
 * Set the default to the given value. Display a notification to the user
 * confirming that the default has been changed to the new value.
 *
 * @param {String} name - The name of the default to set
 * @param {String} value - The new value of the default
 * @returns undefined
 */
function setDefault(name, value) {
  if (!value || value == undefined || value.length == 0) {
    LaunchBar.alert('Invalid default setting', 'The default for "'+name+'" cannot be blank');
    return;
  }

  var prefs = getPreferences();
  prefs[name] = value;

  LaunchBar.displayNotification({
    title: '🍅 Pomodoro',
    string: 'Default ' + name + ' was set to "' + value + '"'
  });
}

/**
 * Retrieve the list previously used pomodoro tasks and format them as LaunchBar
 * result objects. Selecting a historical task will re-run that task.
 *
 * @returns {Array} The list of previously run pomodoro sessions formatted as LaunchBar result objects
 */
function getHistory() {
  var actions = [];
  var prefs   = getPreferences();

  actions.push({title: 'Clear History', icon: 'font-awesome:trash-o', action: 'clearHistory'});

  prefs.history.forEach(function(item) {
    actions.push({
      title: item,
      icon: 'font-awesome:repeat',
      action: 'runWithString',
      actionArgument: item
    });
  });

  return actions;
}

/**
 * Add the given pomodoro string to the beginning of the history list. New
 * entries are added to the head of the list, and older entries are removed from
 * the tail of the list. The history is limited to 10 entries.
 *
 * If an entry already exists in the list, then the previous entry is removed
 * and the new entry is added to the head of the list. This prevents duplicate
 * entries in the history list.
 *
 * @param {String} string - The string to add to the history array
 * @returns udnefined
 */
function addToHistory(string) {
  var prefs = getPreferences();
  if (string == prefs.message) return;

  var history = prefs.history;
  var index   = history.indexOf(string);

  if (index == 0) return;                    // repeating last pomodoro
  if (index > 1 ) history.splice(index, 1);  // remove previous history entry

  history.unshift(string);
  history.splice(10);
}

/**
 * Does what it says on the label - clears the history array of all entries.
 *
 * @returns undefined
 */
function clearHistory() {
  var prefs = getPreferences();
  prefs.history = [];
}

/**
 * Find the system provided sounds and return a list of LaunchBar result
 * objects - one for each sound. The result objects will show the name of the
 * sound and will set the default sound when selected.
 *
 * @returns {Array} The list of available system sounds formatted as LaunchBar result objects
 */
function getSounds() {
  var actions = [];
  var sounds  = File.getDirectoryContents(SOUND_PATH);

  sounds.forEach(function(filename) {
    var name = filename.slice(0, filename.lastIndexOf('.'));
    actions.push({
      title: name,
      icon: 'font-awesome:volume-up',
      action: 'setDefaultSound',
      actionArgument: name,
      actionRunsInBackground: true
    });
  });

  return actions;
}

/**
 * Set the default sound to the named system sound. A notification will be shown
 * confirming that the default has been set, and the sound will be played. If
 * the system sound does not exist then an alert box is shown.
 *
 * @param {String} name - The name of the sound file "Glass" or "Frog" etc
 * @returns undefined
 */
function setDefaultSound(name) {
  var path  = findSound(name);
  var prefs = getPreferences();
  if (path == undefined) return;

  setDefault('sound', name);
  LaunchBar.execute('/usr/bin/afplay', path);
}

/**
 * Play the named system sound. If the system sound does not exist then an alert
 * box is shown.
 *
 * @param {String} name - The name of the sound file "Glass" or "Frog" etc
 * @returns undefined
 */
function playSound(name) {
  var path = findSound(name);
  if (path == undefined) return;

  LaunchBar.execute('/usr/bin/afplay', path);
}

/**
 * Find the system sound and return the full path to the sound file. If the file
 * does not exist, then `undefined` is returned an alert box is shown.
 *
 * @param {String} name - The name of the sound file "Glass" or "Frog" etc
 * @returns {String} The full path to the sound file or `undefined` if it could * not be found
 */
function findSound(name) {
  var path = SOUND_PATH + '/' + name + '.aiff'
  if (File.exists(path)) return path;

  LaunchBar.alert('The sound could not be found', 'The sound file "' + path + '" could not be found.');
  return undefined;
}
