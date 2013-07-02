goog.provide('app');


app.main = function () {
  app.module_list_el_ = goog.dom.getElement('modules');
};


app.registerModule = function (module) {
  var item = goog.dom.createDom('li', {}, module.key);
  app.module_list_el_.appendChild(item);
};


goog.exportSymbol('main', app.main);
