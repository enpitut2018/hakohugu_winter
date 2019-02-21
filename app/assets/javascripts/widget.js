(function () {
    // Add a getElementsByClassName function if the browser doesn't have one
    // Limitation: only works with one class name
    // Copyright: Eike Send http://eike.se/nd
    // License: MIT License

    if (!document.getElementsByClassName) {
        document.getElementsByClassName = function (search) {
            var d = document, elements, pattern, i, results = [];
            if (d.querySelectorAll) { // IE8
                return d.querySelectorAll("." + search);
            }
            if (d.evaluate) { // IE6, IE7
                pattern = ".//*[contains(concat(' ', @class, ' '), ' " + search + " ')]";
                elements = d.evaluate(pattern, d, null, 0, null);
                while ((i = elements.iterateNext())) {
                    results.push(i);
                }
            } else {
                elements = d.getElementsByTagName("*");
                pattern = new RegExp("(^|\\s)" + search + "(\\s|$)");
                for (i = 0; i < elements.length; i++) {
                    if (pattern.test(elements[i].className)) {
                        results.push(elements[i]);
                    }
                }
            }
            return results;
        }
    }
    /*!
     * domready (c) Dustin Diaz 2014 - License MIT
     */
    !function (e, t) {
        typeof module != "undefined" ? module.exports = t() : typeof define == "function" && typeof define.amd == "object" ? define(t) : this[e] = t()
    }("domready", function () {
        var e = [], t, n = document, r = n.documentElement.doScroll, i = "DOMContentLoaded", s = (r ? /^loaded|^c/ : /^loaded|^i|^c/).test(n.readyState);
        return s || n.addEventListener(i, t = function () {
            n.removeEventListener(i, t), s = 1;
            while (t = e.shift()) t()
        }), function (t) {
            s ? setTimeout(t, 0) : e.push(t)
        }
    })
    domready(function () {
        var widget_link, iframe, i, widget_links, target_url;
        widget_links = document.getElementsByClassName('slack-button-widget');
        for (i = 0; i < widget_links.length; i++) {
            widget_link = widget_links[i];
            if (widget_link.dataset.url) {
                target_url = widget_link.dataset.url;
            } else {
                target_url = window.location.href;
            }
            iframe = document.createElement('iframe');
            iframe.setAttribute('src', widget_link.dataset.source + '?url=' + target_url);
            iframe.setAttribute('width', '74');
            iframe.setAttribute('height', '22');
            iframe.setAttribute('frameborder', '0');
            iframe.setAttribute('scrolling', 'no');
            widget_link.parentNode.replaceChild(iframe, widget_link);
        }
    });

})();