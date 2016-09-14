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

$(function() {
  $("[data-slick]").slick();
  $(".js-variant-chooser tr").on("click", function(e) {
    var purchaseURL = $(this).data("purchase-url");
    var price = $(this).data("price");

    $(this).parent().find("tr.active").removeClass("active");
    $(this).addClass("active");
    $(".js-purchase-btn").attr("href", purchaseURL);
    $(".js-purchase-btn span").text(price);
  })

  $("[data-sticky]").each(function() {
    var $el = $(this);
    var offset = $el.offset().top - 20;

    $el.affix({
      offset: {
        top: offset
      }
    })
  })
})
