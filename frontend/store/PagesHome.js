export default new Vuex.Store({
  state: {
    items: [],
  },
  getters: {
    getItems: function (state) {
      console.log("get item");
      return state.items;
    },
  },
  mutations: {
    addItem(state, item) {
      console.log("att item");
      console.log(item);
      state.items.push(item);
    },
  },
  actions: {},
});
