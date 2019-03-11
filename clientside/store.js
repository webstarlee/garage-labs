import Vuex from 'vuex';
import Vue from 'vue';

Vue.use(Vuex);

export default new Vuex.Store({
    state: {
        user: JSON.parse(localStorage.getItem('user'))
    },
    mutations: {
        updateApiToken(state, api_token) {
            state.user.api_token = api_token;
            localStorage.setItem('user', JSON.stringify(state.user));
            Vue.http.headers.common['Authorization'] = `Bearer ${ state.user.api_token }`;
        },
        setUserAvatarPath(state, avatar_path) {
            state.user.avatar_path = avatar_path;
            localStorage.setItem('user', JSON.stringify(state.user));
        },
        setUserCoverPath(state, cover_path) {
            state.user.cover_path = cover_path;
            localStorage.setItem('user', JSON.stringify(state.user));
        },
        setUser(state, user) {
            state.user = user;
            localStorage.setItem('user', JSON.stringify(user));
            Vue.http.headers.common['Authorization'] = `Bearer ${ user.api_token }`;
        },
        login(state, user) {
            state.user = user;
            localStorage.setItem('user', JSON.stringify(user));
            Vue.http.headers.common['Authorization'] = `Bearer ${ user.api_token }`;
        },
        logout(state) {
            state.user = null;
            localStorage.setItem('user', null);
            Vue.http.headers.common['Authorization'] = '';
        },
        setUserType(state, user_type) {
            state.user.i_am = user_type;
            localStorage.setItem('user', JSON.stringify(state.user));
        }
    },
    getters: {
        auth: state => {
            return state.user !== undefined && state.user !== null;
        },
        api_token: state => {
            return state.user ? `Bearer ${ state.user.api_token}` : '';
        },
        user: state => {
            return state.user;
        },
        userCopy: state => {
            return JSON.parse(JSON.stringify(state.user));
        }
    },
    strict: true
});