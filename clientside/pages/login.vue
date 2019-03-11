<template>
    <div class="container wrap-ui content-wrapper" style="min-height: 550px;">
        <div class="row">
            <div class="col-md-12">
                <div class="row">
                    <div class="col-md-12">
                        <h3 class="text-center join-title">{{loginConfig.title}}</h3>
                        <h4 class="text-center join-title">{{loginConfig.signup_remind}}
                            <router-link class="btn btn-xs btn-success no-shadow font-default btn-join margin-zero" v-bind:to="($route.query.caller && $route.query.token) ? `/register?caller=${$route.query.caller}&token=${$route.query.token}` : '/register'">{{loginConfig.signup_button}}</router-link>
                        </h4>
                        <div class="login-form">
                            <form v-on:submit.prevent="login()" name="form">
                                <fieldset v-bind:disabled="loading">
                                    <div class="form-group" v-bind:class="{ 'has-error': errors.email.length }">
                                        <input type="text"
                                               v-model="email"
                                               id="username"
                                               class="form-control login-field"
                                               placeholder="Email"
                                               title="Email"
                                        >
                                        <label class="login-field-icon fui-user" for="username"></label>
                                        <p class="help-block" v-cloak>{{ errors.email.join() }}</p>
                                    </div>
                                    <div class="form-group" v-bind:class="{ 'has-error': errors.password.length }">
                                        <input type="password"
                                               v-model="password"
                                               class="form-control login-field"
                                               id="password"
                                               placeholder="Password"
                                               title="Password"
                                        >
                                        <label class="login-field-icon fui-lock" for="password"></label>
                                        <p class="help-block" v-cloak>{{ errors.password.join() }}</p>
                                    </div>
                                    <div class="alert-danger alert" v-show="errors.message">
                                        Mauvaises informations.
                                    </div>
                                    <button id="buttonSubmit" class="btn btn-block btn-lg btn-success">{{loginConfig.signin_button}}</button>
                                    <label class="btn-block">
                                        <a href="#" class="label-terms recover">{{loginConfig.forgot_password_link}}</a>
                                    </label>
                                </fieldset>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        methods: {
            clearErrors() {
                this.errors.email = [];
                this.errors.message = null;
                this.errors.password = [];
            },
            login() {
                this.loading = true;
                this.clearErrors();
                this.$http.post('/api/auth/login', { email: this.email, password: this.password }).then(response => {
                    this.$store.commit('login', response.data);
                    var caller = this.$route.query.caller;
                    var token = this.$route.query.token;

                    var obj = {
                        path: `/`
                    };

                    if (caller) {
                        obj['path'] = caller;
                    }

                    if (token) {
                        obj['query'] = { token:  token};
                    }

                    this.$router.push(obj);
                }, response => {
                    if(response.message !== undefined) {
                        this.errors.message = response.message;
                    } else {
                        for(let index in response.data) {
                            this.errors[index] = response.data[index];
                        }
                    }
                }).then(() => {
                    this.loading = false;
                });
            },
            fetchContentEn() {
                this.$http.get('/data/content_en.json').then(response => {
                    this.loginConfig = response.body.login;
                }, response => {
                    console.log(response);
                });
            }
        },
        data() {
            return {
                loading: false,
                email: '',
                password: '',
                errors: {
                    message: null,
                    email: [],
                    password: []
                },
                loginConfig: {}
            }
        },
        created() {
            this.fetchContentEn();
        }
    }
</script>