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
                        <span class="btn-block">Company informations<i v-show="loading" class="fa fa-spinner fa-spin fa-3x fa-fw inline"></i></span>
                    </div>
                    <div class="panel-body">
                        <form v-on:submit.prevent="submit()" class="form-horizontal form-account">
                            <fieldset>
                                <div v-if="message" class="alert alert-info">{{ message }}</div>
                                <div class="form-group" v-bind:class="{ 'has-error': errors.name !== undefined }">
                                    <label class="col-sm-3 control-label input-sm">Company name</label>
                                    <div class="col-sm-9">
                                        <input type="text" v-model="company.name" class="form-control input-sm" placeholder="">
                                        <p v-if="errors.name !== undefined" class="help-block">{{ errors.name.join() }}</p>
                                    </div>
                                </div>
                                <div class="form-group" v-bind:class="{ 'has-error': errors.country_id !== undefined }">
                                    <label class="col-sm-3 control-label input-sm">Country</label>
                                    <div class="col-sm-9">
                                       <select v-model="company.country_id" class="form-control input-sm" id="country_id">
                                            <option value="-1">Select list with countries</option>
                                            <option v-for="country in countries" v-bind:value="country.id">{{ country.name }}</option>
                                        </select>
                                        <p v-if="errors.country_id !== undefined" class="help-block">{{ errors.country_id.join() }}</p>
                                    </div>
                                </div>
                                 <div class="form-group" v-bind:class="{ 'has-error': errors.incorporation_number !== undefined }">
                                    <label class="col-sm-3 control-label input-sm">Incorporation number</label>
                                    <div class="col-sm-9">
                                        <input type="text" v-model="company.incorporation_number" class="form-control input-sm" placeholder="">
                                        <p v-if="errors.incorporation_number !== undefined" class="help-block">{{ errors.incorporation_number.join() }}</p>
                                    </div>
                                </div>
                                <div class="form-group" v-bind:class="{ 'has-error': errors.vat_number !== undefined }">
                                    <label class="col-sm-3 control-label input-sm">VAT number</label>
                                    <div class="col-sm-9">
                                        <input type="text" v-model="company.vat_number" class="form-control input-sm" placeholder="">
                                        <p v-if="errors.vat_number !== undefined" class="help-block">{{ errors.vat_number.join() }}</p>
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
                company: {},
                message: null
            }
        },
        created() {
            this.user = this.$store.getters.user;
            this.fetchCountries();
            this.company.country_id = -1;
            this.fetchCompany();
        },
        components: {
            'account-navigation': accountNavigation,
            'user-overview': userOverview
        },
        methods: {
            submit() {
                this.loading = true;
                this.errors = {};

                this.$http.post('/api/account/company', this.company)
                .then(response => {
                    this.company = response.data;
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
            fetchCompany() {
                this.loading = true;

                this.$http.get('/api/account/company').then(response => {
                    if (response.data.id) {
                        this.company = response.data;
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