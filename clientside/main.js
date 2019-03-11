import Vue from 'vue';
import VueRouter from 'vue-router';
import VueResource from 'vue-resource';
import VueMoment from 'vue-moment';
import App from './app.vue';
import routes from './routes';
import store from './store'; 
import EventEmitter from 'events';



Vue.use(VueRouter);
Vue.use(VueResource); 
Vue.use(VueMoment);


/**
 * Basic headers
 */

Vue.http.headers.common['Accept'] = 'application/json';
Vue.http.headers.common['X-Requested-With'] = 'XMLHttpRequest'; 
Vue.http.headers.common['Authorization'] = store.getters.api_token;
Vue.http.options.emulateJSON = true;

const router = new VueRouter({
    mode: 'history',
    routes: routes
});

function getParameterByName(name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}

var lang = getParameterByName('lang', location.href);

if (lang) {
    alert('here');
}

/**
 * Basic routes middlewares
 */


router.beforeEach((to, from, next) => {
    const devMode = to.fullPath === '/v2-dev';
    if(to.fullPath === '/login' || to.fullPath === '/register') {
        document.body.className = 'join-section';
    } else {
        document.body.className = '';
    }
    if(to.matched.some(route => route.meta.forGuests) && store.getters.auth === true) {
        next('/?type=startups');
    }
    if(to.matched.some(route => route.meta.forAuth) && store.getters.auth === false) {
        next('/login');
    }
    if(devMode) {
        next('/?type=startups');
    }

    if (to.query.lang && document.documentElement.lang !== 'fr') {
        document.documentElement.lang = to.query.lang;
    }
    
    next();
});

router.afterEach((to) => {
    window.dispatchEvent(new CustomEvent('routeChanged'));
});

Vue.http.interceptors.push((request, next) => {
    next((response) => {
        if(response.status === 401) {
            store.commit('logout');
            router.go('/login');
        }
    });
});

Vue.directive('datepicker', {
    inserted: (el, binding, vnode) => {
        el.className += ' datepicker';
        el.addEventListener('blur', () => {
            vnode.context[binding.expression](el.value);
        })
    }
});

Vue.filter('capitalize', (value) => {
    return value[0].toUpperCase() + value.substr(1);
});




Vue.prototype.$events = new EventEmitter;

/**
 * Initialize app
 */

const app = new Vue({
    router,
    store,
    render: h => h(App)
}).$mount('#app');
