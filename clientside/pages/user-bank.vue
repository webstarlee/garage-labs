<template>
    <div class="container wrap-ui content-wrapper" v-if="user.i_am.includes('0')">
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
                        <span class="btn-block">Bank informations<i v-show="loading" class="fa fa-spinner fa-spin fa-3x fa-fw inline"></i></span>
                    </div>
                    <div class="panel-body">
                        <form v-on:submit.prevent="submit()" class="form-horizontal form-account">
                            <fieldset>
                                <div v-if="message" class="alert alert-info">{{ message }}</div>
                               <div class="bank-info-container">
                                    <div class="form-group" v-bind:class="{ 'has-error': errors.name !== undefined }">
                                        <label class="col-sm-3 control-label input-sm">Bank name</label>
                                        <div class="col-sm-9">
                                            <input type="text" v-model="bank.name" class="form-control input-sm" placeholder="">
                                            <p v-if="errors.name !== undefined" class="help-block">{{ errors.name.join() }}</p>
                                        </div>
                                    </div>
                                    <div class="form-group" v-bind:class="{ 'has-error': errors.country_id !== undefined }">
                                        <label class="col-sm-3 control-label input-sm">Country</label>
                                        <div class="col-sm-9">
                                        <select v-model="bank.country_id" class="form-control input-sm" id="country_id">
                                                <option value="-1">Select list with countries</option>
                                                <option v-for="country in countries" v-bind:value="country.id">{{ country.name }}</option>
                                            </select>
                                            <p v-if="errors.country_id !== undefined" class="help-block">{{ errors.country_id.join() }}</p>
                                        </div>
                                    </div>
                                    <div class="form-group" v-bind:class="{ 'has-error': errors.iban !== undefined }">
                                        <label class="col-sm-3 control-label input-sm">IBAN</label>
                                        <div class="col-sm-9">
                                            <input type="text" v-model="bank.iban" class="form-control input-sm" placeholder="">
                                            <p v-if="errors.iban !== undefined" class="help-block">{{ errors.iban.join() }}</p>
                                        </div>
                                    </div>
                                     <div class="form-group" v-bind:class="{ 'has-error': errors.sift_bic !== undefined }">
                                        <label class="col-sm-3 control-label input-sm">SWIFT/BIC</label>
                                        <div class="col-sm-9">
                                            <input type="text" v-model="bank.sift_bic" class="form-control input-sm" placeholder="">
                                            <p v-if="errors.sift_bic !== undefined" class="help-block">{{ errors.sift_bic.join() }}</p>
                                        </div>
                                    </div>
                               </div>
                                <div class="form-group">
                                    <div class="col-sm-offset-3 col-sm-9">
                                        <button type="submit" class="btn btn-success btn-sm" style="opacity: 0.7; cursor: default;">Update</button>
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
        data() {
            return {
                user: {},
                errors: {},
                loading: false,
                countries: [],
                bank: {},
                message: null
            }
        },
        created() {
            this.user = this.$store.getters.user;
            this.fetchCountries();
            this.bank.country_id = -1;
            this.fetchBank();
        },
        components: {
            'account-navigation': accountNavigation,
            'user-overview': userOverview
        },
        methods: {
            submit() {
                this.loading = true;
                this.errors = {};

                this.$http.post('/api/account/bank', this.bank)
                .then(response => {
                    this.bank = response.data;
                    this.message = "Updated successfully.";
                }, error => {
                    this.errors = error.data;
                }).finally(() => {
                    this.loading = false;
                })
            },
            fetchCountries() {
                this.loading = true;

                this.$http.get('/api/countries').then(response => {
                    this.countries = response.data;
                }, error => {
                    console.log(error);
                }).finally(() => {
                    this.loading = false;
                });
            },
            fetchBank() {
                this.loading = true;

                this.$http.get('/api/account/bank').then(response => {
                    if (response.data.id) {
                        this.bank = response.data;
                    }
                }, error => {
                    console.log(error);
                }).finally(() => {
                    this.loading = false;
                });
            }
        }
    }
</script>