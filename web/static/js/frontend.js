// Till I can figure out a better
// way to do this
require.context("../assets", true, /(gif|svg|png|jpg|jpeg|ico|txt)$/);


import "phoenix_html";
import "../stylesheets/frontend.scss";

import "bootstrap/js/collapse.js";
import "bootstrap/js/alert.js";
import "bootstrap/js/dropdown.js";
import "bootstrap/js/affix.js";


import "slick-carousel/slick/slick.js";
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";

import Prism from "prismjs";
import "prismjs/components/prism-markup.js"
import "prismjs/components/prism-css.js"
import "prismjs/components/prism-javascript.js";
import "prismjs/components/prism-elixir.js";
import "prismjs/components/prism-bash.js";
import "prismjs/components/prism-scss.js";
import "prismjs/components/prism-ruby.js";

import "prismjs/themes/prism-tomorrow.css";


import Turbolinks from "turbolinks";
Turbolinks.start()

$(function() {
  $(document).on("turbolinks:load", function(event) {
    if(typeof ga === "function") {
      ga("send", "pageview", window.location.pathname)
    }

    Prism.highlightAll();

    $("[data-slick]").slick();

    $("[data-sticky]").each(function() {
      var $el = $(this);
      var offset = $el.offset().top - 20;

      $el.affix({
        offset: {
          top: offset
        }
      })
    })
  }).trigger("turbolinks:load");


  $(document).on("click", ".js-variant-chooser tr", function(e) {
    var purchaseURL = $(this).data("purchase-url");
    var price = $(this).data("price");

    $(this).parent().find("tr.active").removeClass("active");
    $(this).addClass("active");
    $(".js-purchase-btn").attr("href", purchaseURL);
    $(".js-purchase-btn span").text(price);
  })
})
