// ==UserScript==
// @name         iDRAC7 HTML5 Console Fix
// @namespace    idrac7-fix
// @version      5.0
// @description  Fix iDRAC7 HTML5 virtual console on modern browsers
// @match        https://*/virtualconsolehtml5.html*
// @match        https://*/html5viewer.html*
// @run-at       document-start
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

    // Fix 1: window.opener is null in modern browsers (noopener default)
    if (!window.opener) {
        window.opener = window;
    }

    // Fix 2: Load real locale strings from iDRAC, fall back to key names
    window.localeObj = new Proxy({}, {
        get(target, prop) {
            if (typeof prop === 'symbol') return undefined;
            return (prop in target) ? target[prop] : String(prop);
        },
        has() { return true; }
    });

    // Fetch the actual locale JSON and populate localeObj
    var xhr = new XMLHttpRequest();
    xhr.open('GET', '/locale/locale_en.json', false); // synchronous so it loads before scripts run
    try {
        xhr.send();
        if (xhr.status === 200) {
            var data = JSON.parse(xhr.responseText);
            window.localeObj = new Proxy(data, {
                get(target, prop) {
                    if (typeof prop === 'symbol') return undefined;
                    return (prop in target) ? target[prop] : String(prop);
                },
                has() { return true; }
            });
        }
    } catch(e) {
        console.warn('[iDRAC fix] failed to load locale, using key names', e);
    }

    // Fix 3: Stub EntityDecode if missing
    if (typeof window.EntityDecode === 'undefined') {
        window.EntityDecode = function(s) {
            if (!s) return '';
            var el = document.createElement('textarea');
            el.innerHTML = s;
            return el.value;
        };
    }

    // Fix 4: Default language
    window.lang = 'en';

    // Fix 5: Disable cert popup loop
    // The viewer has htmlViewer.disableRPCertPopup() but it's commented out.
    // Hook launchKVM to call it before connecting.
    // Note: Chrome must be launched with --ignore-certificate-errors for the
    // websocket TLS handshake to port 5900 to succeed with self-signed certs.
    document.addEventListener('DOMContentLoaded', function() {
        var origLaunchKVM = window.launchKVM;
        if (origLaunchKVM) {
            window.launchKVM = function(user, pass, port, ip) {
                if (window.htmlViewer && typeof window.htmlViewer.disableRPCertPopup === 'function') {
                    console.log('[iDRAC fix] calling disableRPCertPopup()');
                    window.htmlViewer.disableRPCertPopup();
                }
                return origLaunchKVM.call(this, user, pass, port, ip);
            };
        }
    });

})();
