import axios from 'axios'

export default new Vuex.Store({
  state: {
    status: "init",
    result: {},
  },
  getters: {
    nHits: function (state) {
      if (state.result && state.result.hasOwnProperty('numFound')) {
        return state.result.numFound;
      } else {
        return 0;
      }
    },
    records: function (state) {
      if (state.result && state.result.hasOwnProperty('docs')) {
        return state.result.docs;
      } else {
        return [];
      }
    },
  },
  mutations: {
    setStatus: function (state, status) {
      state.status = status;
    },
    setResult: function (state, data) {
      state.result = data;
    },
  },
  actions: {
    search: function (context, query) {
      if (context.state.status === "loading") {
        return;
      }
      context.commit('setStatus', "loading");
      axios.get('/search.json', {params: {q: query}}).then( function (response) {
        context.commit('setResult', response.data);
        context.commit('setStatus', "succeed");
      }).catch( function (error) {
        context.commit('setStatus', "error");
      })
    },
  }
})
