window.jQuery = require("jquery");
window.$ = window.jQuery;
require("jquery-ujs");
require("jquery-resizable-dom");

import Vue from "vue";

import _ from "lodash";
import store from "store";
window.store = store;
import moment from "moment";
window.moment = moment;

import * as axios from "axios";
window.axios = axios;

import seedrandom from "seedrandom";
window.seedrandom = seedrandom;

import * as history from "history";

import Cookies from "js-cookie";
window.Cookies = Cookies;

import * as Qs from "qs";
window.Qs = Qs;

import Vuetify from "vuetify";
Vue.use(Vuetify);

const opts = {};
export default new Vuetify(opts);
window.Vuetify = Vuetify;

import VueRouter from "vue-router";
window.VueRouter = VueRouter;
Vue.use(VueRouter);

import Vuex from "vuex";
window.Vuex = Vuex;
Vue.use(Vuex);

import ActionCableVue from "actioncable-vue";
Vue.use(ActionCableVue, {
  debug: true,
  debugLevel: "error",
  connectionUrl: "ws://localhost:3000/cable",
  connectImmediately: false,
});

window.Vue = Vue;
