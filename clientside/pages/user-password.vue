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
                        <span class="btn-block">{{ passwordConfig.title }} <i v-show="loading" class="fa fa-spinner fa-spin fa-3x fa-fw inline"></i></span>
                    </div>
                    <div class="panel-body">
                        <form v-on:submit.prevent="submit()" class="form-horizontal form-account">
                            <fieldset>
                                <div v-if="message" class="alert alert-info">{{ message }}</div>
                                <div class="form-group" v-bind:class="{ 'has-error': errors.old_password !== undefined }">
                                    <label class="col-sm-2 control-label input-sm">{{ passwordConfig.old_password }}</label>
                                    <div class="col-sm-10">
                                        <input type="password" v-model="old_password" class="form-control input-sm" placeholder="old password">
                                        <p v-if="errors.old_password !== undefined" class="help-block">{{ errors.old_password.join() }}</p>
                                    </div>
                                </div>
                                <div class="form-group" v-bind:class="{ 'has-error': errors.new_password !== undefined }">
                                    <label class="col-sm-2 control-label input-sm">Nouveau mot de passe</label>
                                    <div class="col-sm-10">
                                        <input type="password" v-model="new_password" class="form-control input-sm" placeholder="Nouveau mot de passe">
                                        <p v-if="errors.new_password !== undefined" class="help-block">{{ errors.new_password.join() }}</p>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-offset-2 col-sm-10">
                                        <button type="submit" class="btn btn-info btn-sm btn-sort" style="opacity: 0.7; cursor: default;">{{ passwordConfig.update }}</button>
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
                message: null,
                user: {},
                errors: {},
                loading: false,
                passwordConfig: {},
                new_password: null,
                old_password: null
            }
        },
        created() {
            this.user = this.$store.getters.user;
        },
        components: {
            'account-navigation': accountNavigation,
            'user-overview': userOverview
        },
        methods: {
            fetchContentEn() {
                this.$http.get('/data/content_en.json').then(response => {
                    this.passwordConfig = response.body.userPassword;
                }, response => {
                    console.log(response);
                });
            },
            submit() {
                this.loading = true;
                this.errors = {};

                this.$http.post('/api/account/update-password', { old_password: this.old_password, new_password: this.new_password }).then(response => {
                    this.$store.commit('updateApiToken', response.data.api_token);

                    this.old_password = null;
                    this.new_password = null;
                    this.message = response.data.message;
                }, error => {
                    this.errors = error.data;
                }).finally(() => {
                    this.loading = false;
                })
            }
        }
    }
</script>