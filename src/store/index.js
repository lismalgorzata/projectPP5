import { createStore } from 'vuex';

export default createStore({
  state: {
    currentUser: null,
  },
  mutations: {
    setCurrentUser(state, user) {
      state.currentUser = user;
      console.log("setCurrentUser() działa", user)
    },
  },
  actions: {
    login({ commit }, user) {
      commit('setCurrentUser', user);
      console.log("login commit działa", user);
    },
    logout({ commit }) {
      commit('setCurrentUser', null);
    },
  },
  getters: {
    getCurrentUser: (state) => {
        const currentUser = state.currentUser;
        console.log('getCurrentUser działa', currentUser);
        return currentUser;
      }
  },
});