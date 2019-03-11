<template>
    <div>
        <div v-if="auth" class="panel panel-default">
            <div class="position-relative">
                <div class="btn-block">
                    <div style="margin-left:15px; margin-top:10px; margin-right:12px">
                        <form>
                            <fieldset v-bind:disabled="loading">
                                <div class="form-group" v-bind:class="{ 'has-error': errors.message !== undefined }">
                                    <label>Suggest something <i v-show="loading" class="fa fa-spinner fa-spin fa-3x fa-fw inline"></i></label>
                                    <textarea v-model="message" class="form-control" style="margin-top:10px; height:130px" placeholder="Your message..."></textarea>
                                    <p v-if="errors.message !== undefined" class="help-block">{{ errors.message.join() }}</p>
                                </div>
                                <div class="form-group" v-bind:class="{ 'has-error': errors.offer !== undefined }">
                                    <input v-model="offer" type="text" class="form-control input-sm" style="margin-top:-15px;" placeholder="1000€">
                                    <p v-if="errors.offer !== undefined" class="help-block">{{ errors.offer.join() }}</p>
                                </div>
                                <div class="form-group">
                                    <button v-on:click="send()" class="btn btn-lg btn-block btn-like-shots btn-danger btn-like shotTooltip">Envoyer</button>
                                </div>
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div v-else class="alert alert-warning text-center" role="alert">
            You must be logged in to apply <router-link to="/login">Identify Me</router-link>
            - <router-link to="/register">Register</router-link>
        </div>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                offer: null,
                message: null,
                errors: {},
                loading: false
            }
        },
        methods: {
            send() {
                this.loading = true;
                this.errors = {};

                this.$http.post('/api/proposals', {
                    project_id: this.project.id,
                    offer: this.offer,
                    message: this.message
                }).then(response => {
                    this.$emit('proposalCreated', response.data);
                }, response => {
                    this.errors = response.data;
                }).then(() => {
                    this.loading = false;
                });
            }
        },
        computed: {
            auth: function() {
                return this.$store.getters.auth;
            },
            user: function() {
                return this.$store.getters.user;
            }
        },
        props: ['project']
    }
</script>