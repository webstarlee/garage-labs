<template>
    <div>
        <!-- Modal -->
        <div id="chatModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <div v-if="auth" class="panel panel-default">
                            <div class="position-relative">
                                <div class="btn-block">
                                    <div style="margin-left:15px; margin-top:10px; margin-right:12px">
                                        <form v-on:submit.prevent="send()">
                                            <fieldset v-bind:disabled="loading">
                                                <div class="form-group" v-bind:class="{ 'has-error': errors.message !== undefined }">
                                                    <label>Je suis intéressé par la start-up <i v-show="loading" class="fa fa-spinner fa-spin fa-3x fa-fw inline"></i></label>
                                                    <textarea v-model="message" class="form-control" style="margin-top:10px; height:130px" placeholder="Votre message à l’auteur du projet"></textarea>
                                                    <p v-if="errors.message !== undefined" class="help-block">{{ errors.message.join() }}</p>
                                                </div>
                                                <div class="form-group">
                                                    <button class="btn btn-lg btn-block btn-like-shots btn-danger btn-like shotTooltip">Envoyer</button>
                                                </div>
                                            </fieldset>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div v-else class="alert alert-warning text-center" role="alert">
                            You must be logged in to apply <router-link to="/login">Identify me</router-link>
                            - <router-link to="/register">Register</router-link>
                        </div>
                    </div>
                </div>
            </div>
        </div>  
    </div>
</template>

<script>
    export default {
        data() {
            return {
                message: null,
                errors: {},
                loading: false
            }
        },
        methods: {
            send() {
                this.loading = true;
                this.errors = {};

                this.$http.post('/api/contacts/save', {
                    start_up_id: this.startup.id,
                    message: this.message
                }).then(response => {
                    this.$emit('contactCreated', response.data);
                    this.message = null;
                    $('#chatModal').modal('hide');
                }, response => {
                    this.errors = response.data;
                    alert('Failed to send message.');
                }).finally(() => {
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
        props: ['startup']
    }
</script>