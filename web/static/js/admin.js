import "phoenix_html";

// Bootstrap
import "bootstrap/js/collapse.js";
import "bootstrap/js/alert.js";
import "bootstrap/js/dropdown.js";

import "slick-carousel/slick/slick.js";
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";

// Custom
import "./admin/pages/product.js";
import {initEditor, initMiniEditor} from "./admin/utils/editor.js";

// Styles
import "../stylesheets/admin.scss";

$(function() {
  if($("#editor").length) {
    initEditor("#editor")
  }

  if($("#mini-editor").length) {
    initMiniEditor("#mini-editor")
  }

  $("[data-slick]").slick()
})
