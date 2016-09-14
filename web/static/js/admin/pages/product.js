import sluggify from "../utils/sluggify.js";

$(function() {
  $("[data-sluggify]").on("keyup", function(e) {
    var $sluggedInput = $($(this).data("sluggify"));
    if(!$sluggedInput.data("touched")) {
      var val = $(this).val()
      $sluggedInput.val(sluggify(val))
    }
  });

  $(".js-slug-field").on("change", function(e) {
    $(this).data("touched", "true")
  })


  var $variantContainer = $("#variants-form-list");
  var $addVariantBtn = $("#add-variant-btn");
  $addVariantBtn.on("click", function(e) {
    e.preventDefault();
    var uniqID = new Date().getTime()
    var template = $(this).data("template")
      .replace(/\[0\]/g, `[${uniqID}]`)
      .replace(/_0_/g, `_${uniqID}_`);

    $variantContainer.append(template)
  })

  if($variantContainer.length) {
    var items = $variantContainer.find(".variant-form-item")
    if(!items || !items.length) {
      $addVariantBtn.trigger("click")
    }
  }

});
