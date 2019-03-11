<template>
    <div class="container wrap-ui content-wrapper">
        <div class="col-md-8">
            <div class="panel panel-default">
                <div v-if="! loading" class="panel-heading">
                    <h3>
                        <template v-if="! exists">
                            Laisser une note
                        </template>
                        <template v-else>
                            Feedback
                        </template>
                            for user {{ proposal.author.first_name }} {{ proposal.author.last_name }}
                        <i v-show="sending" class="fa fa-spinner fa-spin fa-3x fa-fw inline"></i>
                    </h3>
                </div>
                <div class="panel-body">
                    <div v-if="loading" class="text-center spinner-container">
                        <i class="fa fa-spinner fa-spin fa-3x fa-fw"></i>
                    </div>
                    <div v-else>
                        <div v-if="exists">
                            <legend>{{ proposal.project.title }}</legend>
                            <div class="form-group">
                                <label>Message</label>
                                <p>{{ feedback.message }}</p>
                            </div>
                            <div class="form-group">
                                <label>Note</label>
                                <p>{{ feedback.rating }}/5</p>
                            </div>
                        </div>
                        <form v-if="! exists" v-on:submit.prevent="send()">
                            <legend>{{ proposal.project.title }}</legend>
                            <fieldset v-bind:disabled="sending">
                                <div class="form-group" v-bind:class="{ 'has-error': errors.message !== undefined }">
                                    <label>Message</label>
                                    <textarea v-model="feedback.message"
                                              class="form-control input-sm"
                                              placeholder="It was a pleasure to work with you"
                                    ></textarea>
                                    <p v-if="errors.message !== undefined" class="help-block">{{ errors.message.join() }}</p>
                                </div>
                                <div class="form-group" v-bind:class="{ 'has-error': errors.rating !== undefined }">
                                    <label>Note (1/5)</label>
                                    <select v-model="feedback.rating" class="form-control select-sm input-sm">
                                        <option value="1">1</option>
                                        <option value="2">2</option>
                                        <option value="3">3</option>
                                        <option value="4">4</option>
                                        <option value="5">5</option>
                                    </select>
                                    <p v-if="errors.rating !== undefined" class="help-block">{{ errors.rating.join() }}</p>
                                </div>
                                <button class="btn btn-block btn-sm btn-primary">Envoyer</button>
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script type="text/babel">
    export default {
        data() {
            return {
                exists: false,
                loading: true,
                errors: {},
                sending: false,
                proposal: {},
                feedback: {}
            }
        },
        created() {
            this.fetch();
        },
        methods: {
            send() {
                this.sending = true;
                this.errors = {};

                setTimeout(() => {
                    this.$http.post(`/api/feedbacks`, this.feedback).then(() => {
                        this.exists = true;
                    }, response => {
                        this.errors = response.data;
                    }).finally(() => {
                        this.sending = false;
                    });
                }, 0);
            },
            fetch() {
                setTimeout(() => {
                    this.$http.get(`/api/proposals/${ this.$route.query.proposal_id }`).then(response => {
                        this.proposal = response.data;

                        if (response.data.project.feedback === null) {
                            this.feedback.receiver_id = this.proposal.author_id;
                            this.feedback.project_id = this.proposal.project_id;
                        } else {
                            this.exists = true;
                            this.feedback = response.data.project.feedback;
                        }
                    }, error => {
                        console.log(error);
                    }).finally(() => {
                        this.loading = false;
                    });
                }, 0);
            }
        }
    }
</script>

<style scoped>
    .panel-body {
        overflow: auto;
    }

    .spinner-container {
        padding: 50px 0;
    }
</style>