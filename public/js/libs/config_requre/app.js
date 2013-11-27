define([
  // Libraries.
  "jquery",
  "lodash",
  "backbone",
  "jquery_mousewheel",
  "slickcustomscroll",

  // Plugins.
  "backbone_layoutmanager",
//  "backbone_collectioncache",
  "bootstrap",
  "serialize_object",
  "bootstrap_popover",
  "backbone_validation",
  "bootstrap_validation_popover",
  "bootstrap_editable",
  "backbone_vform_view",
  "backbone_extras",
  "slickcustomscroll",
  "jquery_mousewheel",
  "parsley",
  //"jquery_img",
  
  

  
  //Plugins home page
  
    "jquery_parallax",
    "jquery_localscroll",
    "jquery_scrollTo",
    "radio",
    "cusel_min",
    "jquery_validate",
    "filepicker",
    "jquery_cycle",
    "jquery_ui",
    "jquery_u_touch_punch", 
    "jquery_tipsy",  
    "tinyscrollbar", 
//    "jquery_timeline",
//    "wufoo",
    "html5"
  
],

function($, _, Backbone) {

    $.support.cors = true

    // Provide a global location to place configuration settings and module
    // creation.
    Backbone.Collection.prototype.fetch = function() {
        var fetch = Backbone.Collection.prototype.fetch;
        return function() {
            this.trigger("fetch");

            return fetch.apply(this, arguments);
        };
    }();


  var app = {
    // The root path to run the application.
    root: "/"
  };

//  app.apiPath = "http://localhost:3001/";
  app.apiPath = "/server/";

  // Localize or create a new JavaScript Template object.
  var JST = window.JST = window.JST || {};

  // Configure LayoutManager with Backbone Boilerplate defaults.
  Backbone.LayoutManager.configure({
    // Allow LayoutManager to augment Backbone.View.prototype.
    manage: true,

    paths: {
      layout: "app/templates/layouts/",
      template: "app/templates/"
    },

    fetch: function(path) {
      // Initialize done for use in async-mode
      var done;

      // Concatenate the file extension.
      path = path + ".html";

      // If cached, use the compiled template.
      if (JST[path]) {
        return JST[path];
      } else {
        // Put fetch into `async-mode`.
        done = this.async();

        // Seek out the template asynchronously.
        return $.ajax({ url: app.root + path }).then(function(contents) {
          done(JST[path] = _.template(contents));
        });
      }
    }
  });

  // Mix Backbone.Events, modules, and layout management into the app object.
  return _.extend(app, {
    // Create a custom object with a nested Views object.
    module: function(additionalProps) {
      return _.extend({ Views: {} }, additionalProps);
    },

    // Helper for using layouts.
    useLayout: function(name, options) {
      // If already using this Layout, then don't re-inject into the DOM.
      if (this.layout && this.layout.options.template === name) {
        return this.layout;
      }

      // If a layout already exists, remove it from the DOM.
      if (this.layout) {
        this.layout.remove();
      }

      // Create a new Layout with options.
      var layout = new Backbone.Layout(_.extend({
        template: name,
        className: "layout " + name,
        id: "layout"
      }, options));

      // Insert into the DOM.
      $("#main").empty().append(layout.el);

      // Render the layout.
      layout.render();

      // Cache the refererence.
      this.layout = layout;

      // Return the reference, for chainability.
      return layout;
    },
    


    
    
    
  }, Backbone.Events);

});
