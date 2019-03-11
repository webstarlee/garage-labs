<template>
    <div class="container wrap-ui content-wrapper">
        <div class="row">
            <div class="col-md-4">
                <div class="responsive-side collapse">
                    <user-overview v-bind:data="user"></user-overview>
                    <account-navigation></account-navigation>
                </div>
            </div>
            <div class="col-md-8">
                <div class="panel panel-default">
                    <div class="panel-heading grid-panel-title">
                        <span class="btn-block">Mettre à jour mon profil</span>
                    </div>
                    <div class="panel-body">
                        <form class="form-horizontal form-account" role="form">
                            <fieldset v-bind:disabled="loading">
                                <div class="form-group" v-bind:class="{ 'has-error': errors.first_name !== undefined }">
                                    <label for="firstname" class="col-sm-2 control-label input-sm">First name</label>
                                    <div class="col-sm-10">
                                        <input type="text" v-model="user.first_name" class="form-control input-sm" id="firstname" placeholder="Prénom" />
                                        <p v-if="errors.first_name !== undefined" class="help-block">{{ errors.first_name.join() }}</p>
                                    </div>
                                </div>
                                <!-- **** form-group **** -->
                                <div class="form-group" v-bind:class="{ 'has-error': errors.last_name !== undefined }">
                                    <label for="last_name" class="col-sm-2 control-label input-sm">Last name</label>
                                    <div class="col-sm-10">
                                        <input type="text" id="last_name" v-model="user.last_name" class="form-control input-sm" placeholder="Nom de famille" />
                                        <p v-if="errors.last_name !== undefined" class="help-block">{{ errors.last_name.join() }}</p>
                                    </div>
                                </div>
                                <!-- **** form-group **** -->
                                <div class="form-group" v-bind:class="{ 'has-error': errors.username !== undefined }">
                                    <label for="username" class="col-sm-2 control-label input-sm">Username
                                        <i class="icon-question" title="It can not be edited"></i>
                                    </label>
                                    <div class="col-sm-10">
                                        <input id="username" disabled="disabled" v-model="user.username" class="form-control input-sm" placeholder="Pseudonyme" />
                                        <p v-if="errors.username !== undefined" class="help-block">{{ errors.username.join() }}</p>
                                    </div>
                                </div>
                                <!-- **** form-group **** -->
                                <div class="form-group" v-bind:class="{ 'has-error': errors.email !== undefined }">
                                    <label for="email" class="col-sm-2 control-label input-sm">Email</label>
                                    <div class="col-sm-10">
                                        <input v-model="user.email" class="form-control input-sm" id="email" placeholder="Email" />
                                        <p v-if="errors.email !== undefined" class="help-block">{{ errors.email.join() }}</p>
                                    </div>
                                </div>
                                <!-- **** form-group **** -->
                                <div class="form-group" v-bind:class="{ 'has-error': errors.company_name !== undefined }">
                                    <label for="company_name" class="col-sm-2 control-label input-sm">Société</label>
                                    <div class="col-sm-10">
                                        <input v-model="user.company_name" class="form-control input-sm" id="company_name" placeholder="Nom de la société" />
                                        <p v-if="errors.company_name !== undefined" class="help-block">{{ errors.company_name.join() }}</p>
                                    </div>
                                </div>
                                <!-- **** form-group **** -->
                                <div class="form-group" v-bind:class="{ 'has-error': errors.company_phone !== undefined }">
                                    <label for="company_phone" class="col-sm-2 control-label input-sm">Incorporation number</label>
                                    <div class="col-sm-10">
                                        <input v-model="user.company_phone" class="form-control input-sm" id="company_phone" placeholder="Téléphone" />
                                        <p v-if="errors.company_name !== undefined" class="help-block">{{ errors.company_phone }}</p>
                                    </div>
                                </div>
                                <!-- **** form-group **** -->
                                <div class="form-group" v-bind:class="{ 'has-error': errors.city_id !== undefined }">
                                    <label for="address" class="col-sm-2 control-label input-sm">Address</label>
                                    <div class="col-sm-10">
                                        <input v-model="user.address" class="form-control input-sm" id="address" placeholder="Adresse" />
                                        <p v-if="errors.city_id !== undefined" class="help-block">{{ errors.city_id.join() }}</p>
                                    </div>
                                </div>
                                <!-- **** form-group **** -->
                                <div class="form-group" v-bind:class="{ 'has-error': errors.postal_code !== undefined }">
                                    <label for="postal_code" class="col-sm-2 control-label input-sm">Code postal</label>
                                    <div class="col-sm-10">
                                        <input v-model="user.postal_code" class="form-control input-sm" id="postal_code" placeholder="75008" />
                                        <p v-if="errors.postal_code !== undefined" class="help-block">{{ errors.postal_code.join() }}</p>
                                    </div>
                                </div>
                                <!-- **** form-group **** -->
                                <div class="form-group" v-bind:class="{ 'has-error': errors.country_id !== undefined }">
                                    <label for="country_id" class="col-sm-2 control-label input-sm">Pays</label>
                                    <div class="col-sm-10">
                                        <select v-model="user.country_id" v-on:change="updateCities()" class="form-control input-sm" id="country_id">
                                            <option v-for="country in countries" v-bind:value="country.id">{{ country.name }}</option>
                                        </select>
                                        <p v-if="errors.country_id !== undefined" class="help-block">{{ errors.country_id.join() }}</p>
                                    </div>
                                </div>
                                <!-- **** form-group **** -->
                                <div class="form-group" v-bind:class="{ 'has-error': errors.city_id !== undefined }">
                                    <label for="city_id" class="col-sm-2 control-label input-sm">Ville</label>
                                    <div class="col-sm-10">
                                        <select v-model="user.city_id" class="form-control input-sm" id="city_id">
                                            <option v-for="city in cities" v-bind:value="city.id">{{ city.name }}</option>
                                        </select>
                                        <p v-if="errors.city_id !== undefined" class="help-block">{{ errors.city_id.join() }}</p>
                                    </div>
                                </div>
                                <!-- **** form-group **** -->
                                <div class="form-group" v-bind:class="{ 'has-error': errors.website !== undefined }">
                                    <label for="website" class="col-sm-2 control-label input-sm">Site internet</label>
                                    <div class="col-sm-10">
                                        <input v-model="user.website" class="form-control input-sm" id="website" />
                                        <p v-if="errors.website !== undefined" class="help-block">{{ errors.website.join() }}</p>
                                    </div>
                                </div>
                                <!-- **** form-group **** -->
                                <hr>
                                <!-- **** form-group **** -->
                                <div class="form-group">
                                    <label for="email_notifications" class="col-sm-2 control-label input-sm">Notifications par email</label>
                                    <div class="col-sm-10">
                                        <div class="picker picker-checkbox ">
                                            <div class="picker-handle">
                                                <div class="picker-flag"></div>
                                            </div>
                                            <label class="checkbox-inline picker-label">
                                                <input id="check_0" class="no-show picker-element" type="checkbox" value="1" name="email_notification_msg">
                                                <span class="input-sm">Messages and notifications</span>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <!-- **** form-group **** -->
                                <hr>
                                <div class="form-group">
                                    <div class="col-sm-2 pr-0 text-right">
                                        <i v-show="loading" class="fa fa-spinner fa-spin fa-3x fa-fw"></i>
                                    </div>
                                    <div class="col-sm-10">
                                        <button v-on:click="update()" class="btn btn-info btn-sm btn-sort">Mettre à jour</button>
                                        <a href="javascript:void(0);" class="delete-account pull-right">
                                            <small>Fermer mon compte</small>
                                        </a>
                                    </div>
                                </div>
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import accountNavigation from '../components/account-navigation.vue';
    import userOverview from '../components/user-overview.vue';

    export default {
        created() {
            this.user = this.$store.getters.userCopy;

            setTimeout(() => {
                this.fetchLocationData();
            }, 0);
        },
        data() {
            return {
                errors: {},
                loading: false,
                cities: [],
                countries: [],
                user: {}
            }
        },
        methods: {
            update() {
                this.loading = true;
                this.errors = {};

                this.$http.post('/api/account/update', this.user).then(response => {
                    this.$store.commit('setUser', response.data);
                }, error => {
                    this.errors = error.data;
                }).finally(() => {
                    this.loading = false;
                });
            },
            fetchLocationData() {
                this.loading = true;

                Promise.all([
                    this.fetchCountries(),
                    this.fetchCities()
                ]).then(results => {
                    this.countries = results[0].data;
                    this.cities = results[1].data;
                    this.loading = false;
                });
            },
            updateCities() {
                this.loading = true;

                this.fetchCities().then(response => {
                    this.cities = response.data;
                }, error => {
                    console.log(error);
                }).finally(() => {
                    this.loading = false;
                });
            },
            fetchCountries() {
                return this.$http.get('/api/countries');
            },
            fetchCities() {
                return this.$http.get(`/api/countries/${ this.user.country_id }/cities`);
            }
        },
        computed: {
            auth() {
                return this.$store.getters.auth;
            }
        },
        components: {
            'account-navigation': accountNavigation,
            'user-overview': userOverview
        }
    }
</script>