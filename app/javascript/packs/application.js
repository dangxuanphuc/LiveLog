import "bootstrap";
import "../stylesheets/custom";
import "@fortawesome/fontawesome-free/js/all";
import $ from 'jquery';
global.$ = jQuery;
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("select2")
require("packs/songs")
require("packs/lives")
require("channels")
