<template>
    <div class="container wrap-ui content-wrapper-sm">
        <div class="row">
            <div class="col-md-12">
                <div class="row">
                    <div class="col-md-12">
                        <h3 class="text-center join-title">{{registerConfig.title}}</h3>
                        <h4 class="text-center join-title">
                            {{registerConfig.signin_remind}}
                            <router-link to="/login" class="btn btn-xs btn-success no-shadow font-default btn-join margin-zero">{{registerConfig.signin_button}}</router-link>
                        </h4>
                        <div class="login-form">
                            <form name="form" id="signup_form" v-on:submit.prevent="register()">
                                <fieldset v-bind:disabled="loading">
                                    <div v-bind:style="{display: !data.completed ? 'block': 'none'}">
                                        <div class="form-group" v-bind:class="{ 'has-error': errors.first_name.length }">
                                            <input type="text"
                                                v-model="data.first_name"
                                                class="form-control login-field"
                                                id="first_name"
                                                placeholder="First name">
                                            <label class="login-field-icon fui-user" for="first_name"></label>
                                            <p class="help-block" v-cloak>{{ errors.first_name.join() }}</p>
                                        </div>
                                        <div class="form-group" v-bind:class="{ 'has-error': errors.last_name.length }">
                                            <input type="text"
                                                v-model="data.last_name"
                                                class="form-control login-field"
                                                id="last_name"
                                                placeholder="Last name"
                                            >
                                            <label class="login-field-icon fui-user" for="last_name"></label>
                                            <p class="help-block" v-cloak>{{ errors.last_name.join() }}</p>
                                        </div>
                                        <div class="form-group" v-bind:class="{ 'has-error': errors.username.length }">
                                            <input type="text"
                                                v-model="data.username"
                                                class="form-control login-field"
                                                id="username"
                                                placeholder="username"
                                                title="username"
                                            >
                                            <label class="login-field-icon fui-user" for="username"></label>
                                            <p class="help-block" v-cloak>{{ errors.username.join() }}</p>
                                        </div>
                                        <div class="form-group" v-bind:class="{ 'has-error': errors.country_id !== undefined && errors.country_id.length }" v-bind:disabled="loadingCountry">
                                            <div>
                                                <div id="categories-bloc">
                                                    <select 
                                                        v-model="data.country_id"
                                                        class="input-sm"
                                                        v-bind:key="index"
                                                        @change="fetchCities(data.country_id)"
                                                        required
                                                        >
                                                            <option v-for="country in countries" v-bind:value="country.id" v-bind:key="country.id">{{ country.name }}</option>
                                                    </select>
                                                    <p v-if="errors.country_id !== undefined" class="help-block">{{ errors.country_id.join() }}</p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group" v-bind:class="{ 'has-error': errors.city_id !== undefined && errors.city_id.length }">
                                            <div>
                                                <div id="categories-bloc">
                                                    <div id="loader_gif_registeration" v-if="loadingCity"></div>
                                                    <select v-if="!loadingCity"
                                                        v-model="data.city_id"
                                                        class="input-sm"
                                                        v-bind:key="index"
                                                        required
                                                        >
                                                            <option v-for="city in cities" v-bind:value="city.id" v-bind:key="city.id">{{ city.name }}</option>
                                                    </select>
                                                    <p v-if="errors.city_id !== undefined" class="help-block">{{ errors.city_id.join() }}</p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group" v-bind:class="{ 'has-error': errors.email.length }">
                                            <input type="text"
                                                id="email"
                                                v-model="data.email"
                                                class="form-control login-field"
                                                placeholder="Email"
                                            >
                                            <label class="login-field-icon fui-mail" for="email"></label>
                                            <p class="help-block" v-cloak>{{ errors.email.join() }}</p>
                                        </div>
                                        <div class="form-group" v-bind:class="{ 'has-error': errors.phone.length }">
                                            <input type="text"
                                                v-model="data.phone"
                                                class="form-control login-field"
                                                id="phone"
                                                placeholder="Phone Number"
                                            >
                                            <label class="login-field-icon fui-mail" for="phone"></label>
                                            <p class="help-block" v-cloak>{{ errors.phone.join() }}</p>
                                        </div>
                                        <div class="form-group" v-bind:class="{ 'has-error': errors.password.length }">
                                            <input type="password"
                                                v-model="data.password"
                                                class="form-control login-field"
                                                id="password"
                                                placeholder="Password"
                                                title="Password"
                                            >
                                            <label class="login-field-icon fui-lock" for="password"></label>
                                            <p class="help-block" v-cloak>{{ errors.password.join() }}</p>
                                        </div>
                                    </div>
                                    <div v-if="data.completed" class="register-wrapper">
                                        <div class="form-group" v-bind:class="{ 'has-error': errors.i_am.length }">
                                            <p>Vous êtes (<i class="noted-text">{{registerConfig.at_least_one}}</i>)</p>
                                            <div class="checkbox-wrapper">
                                                <input type="checkbox" value="0" v-model="data.i_am"  id="i_am1" />
                                                <label for="i_am1">{{registerConfig.checkbox[0]}}</label>
                                            </div>
                                            <div class="checkbox-wrapper">
                                                <input type="checkbox" value="1" v-model="data.i_am" id="i_am2" />
                                                <label for="i_am2">{{registerConfig.checkbox[1]}}</label>
                                            </div>
                                            <div class="checkbox-wrapper">
                                                <input type="checkbox" value="2" v-model="data.i_am" id="i_am3" />
                                                <label for="i_am3">{{registerConfig.checkbox[2]}}</label>
                                            </div>
                                            <p class="help-block" v-cloak>{{ errors.i_am.join() }}</p>
                                        </div>
                                        <div class="form-group" v-bind:class="{ 'has-error': errors.skills !== undefined && errors.skills.length }">
                                            <div>
                                                <div id="categories-bloc">
                                                    <p>{{registerConfig.skill}} (<i class="noted-text">{{registerConfig.at_least_one}}</i>)</p>
                                                    <div v-for="(skill, index) in data.skills" style="margin-bottom: 10px">
                                                        <select 
                                                                v-model="skill.id"
                                                                class="input-sm"
                                                                v-bind:key="index"
                                                        >
                                                            <option v-for="skill1 in skills" v-bind:value="skill1.id" v-bind:key="skill1.id">{{ skill1.name }}</option>
                                                        </select>
                                                        <input type="text" class="form-control" v-model="skill.other" v-if="skill.id == 0" required placeholder="Vos compétences" />
                                                    </div>
                                                    <p v-if="errors.skills !== undefined" class="help-block">{{ errors.skills.join() }}</p>
                                                </div>
                                                + <a href="javascript:void(0)" @click="addSkill()"><u>{{registerConfig.add_more_skills}}Ajouter une compétence</u></a>
                                            </div>
                                        </div>
                                        <div class="form-group" v-bind:class="{ 'has-error': errors.linkedin_url.length }">
                                            <input type="text"
                                                v-model="data.linkedin_url"
                                                class="form-control login-field"
                                                id="linkedin_url"
                                                placeholder="URL de votre profil LinkedIn"
                                            >
                                            <p class="help-block" v-cloak>{{ errors.linkedin_url.join() }}</p>
                                        </div>
                                    </div>
                                    <button type="submit" id="buttonSubmit" class="btn btn-block btn-lg btn-success">{{!data.completed ? registerConfig.signup_button: registerConfig.finish_register}}</button>
                                    <label class="text-center" v-if="data.completed">
                                        <span class="label-terms">{{registerConfig.confirm_term}}</span>
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
                this.errors = {
                    first_name: [],
                    last_name: [],
                    username: [],
                    email: [],
                    phone: [],
                    password: [],
                    i_am: [],
                    linkedin_url: []
                };
            },
            register() {
                this.clearErrors();
                this.loading = true;

                this.$http.post('/api/auth/register', this.data).then(response => {
                    if (this.data.completed) {
                        // this.$store.commit('login', response.data);

                        var caller = this.$route.query.caller;
                        var token = this.$route.query.token;
                        var obj = {
                            path: `/login`
                        };

                        if (caller && token) {
                            obj['query'] = {caller: caller, token: token};
                        }

                        this.$router.push(obj);
                    } else {
                        this.data.completed = true;
                    }
                }, response => {
                    for(let index in response.data) {
                        this.errors[index] = response.data[index];
                    }
                }).then(() => {
                    this.loading = false;
                });
            },
            addSkill() {
                var len = this.data.skills.length;
                if (len > 0 && this.data.skills[len-1].id === null) {
                    alert('Veuillez remplir ci-dessus la liste des compétences avant ajouter une compétence');
                    return;
                }

                this.data.skills.push({id: null});
            },
            fetchSkills() {
                 this.$http.get('/api/skills').then(response => {
                    this.skills = response.data;
                }).finally(() => {
                    this.loading = false;
                });
            },
            fetchCountries() {
                this.loadingCountry = true;
                 this.$http.get('/api/countries').then(response => {
                    this.countries = response.data;
                }).finally(() => {
                    this.loadingCountry = false;
                });
            },
            fetchCities(countryId) {
                this.loadingCity = true;
                 this.$http.get(`/api/countries/${countryId}/cities`).then(response => {
                    this.cities = response.data;
                }).finally(() => {
                    this.loadingCity = false;
                });
            },
            fetchContentEn() {
                this.$http.get('/data/content_en.json').then(response => {
                    this.registerConfig = response.body.register;
                }, response => {
                    console.log(response);
                });
            }
        },
        data() {
            return {
                loading: false,
                loadingCountry: false,
                loadingCity: false,
                data: {
                    first_name: '',
                    last_name: '',
                    username: '',
                    email: '',
                    phone: '',
                    password: '',
                    i_am: [],
                    completed: false,
                    skills: [],
                    linkedin_url: '',
                    country_id: null,
                    city_id: null
                },
                errors: {
                    first_name: [],
                    last_name: [],
                    username: [],
                    email: [],
                    phone: [],
                    password: [],
                    i_am: [],
                    linkedin_url: [],
                    country: []
                },
                skills: [
                    {text: 'Mobile development'}
                ],
                countries: [],
                cities:[],
                registerConfig: {}
            }
        },
        created() {
            this.fetchSkills();
            this.addSkill();
            this.fetchCountries();
            this.fetchContentEn();
        }
    }
</script>