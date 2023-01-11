import axios from 'axios'

export default new Vuex.Store({
  state: {
    status: "init",
    result: {},
  },
  getters: {
    responses: function (state) {
      if (state.result && state.result.hasOwnProperty('responses')) {
        return state.result.responses;
      } else {
        return [];
      }
    },
    histories: function (state) {
      if (state.result && state.result.hasOwnProperty('histories')) {
        return state.result.histories;
      } else {
        return [];
      }
    },
    trace: function (state) {
      if (state.result && state.result.hasOwnProperty('trace')) {
        return state.result.trace;
      } else {
        return {
          'x': [],
          'y': []
        };
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
      axios.get('/search.json', {params: {
          q: query.searchWord,
          s: query.startDate,
          e: query.endDate
        }}).then( function (response) {
        context.commit('setResult', response.data);
        context.commit('setStatus', "succeed");
      }).catch( function (error) {
        context.commit('setStatus', "error");
      })
    },
    index: function (context) {
      if (context.state.status === "loading") {
        return;
      }
      context.commit('setStatus', "loading");
      axios.get('/index.json').then( function (response) {
        context.commit('setResult', response.data);
        context.commit('setStatus', "succeed");
      }).catch( function (error) {
        context.commit('setStatus', "error");
      })
    },
    destroy: function (context, query) {
      if (context.state.status === "loading") {
        return;
      }
      context.commit('setStatus', "loading");
      axios.get('/destroy.json', {params: {q: query}}).then( function (response) {
        context.commit('setResult', response.data);
        context.commit('setStatus', "succeed");
      }).catch( function (error) {
        context.commit('setStatus', "error");
      })
    },
  }
})
