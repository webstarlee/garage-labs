<template>
    <div>
    <div class="container wrap-ui content-wrapper">
        <div class="row">
            <div class="col-md-offset-2 col-md-8">
                <div class="panel panel-default">
                    <div class="header">
                    DÉPOSER UN DOSSIER DE LEVÉE DE FONDS
                    </div>
                    <div class="panel-body">
                        <form class="form-horizontal form-account" role="form" v-on:submit.prevent="submit()">
                            <fieldset v-bind:disabled="loading">
                                <div class="form-group" v-bind:class="{ 'has-error': errors.title !== undefined && errors.title.length }">
                                    <div class="col-sm-12">
                                        <input type="text"
                                                v-model="form.title"
                                                class="form-control input-sm"
                                                placeholder="Nom de la startup / projet"
                                        >
                                        <p v-if="errors.title !== undefined" class="help-block">{{ errors.title.join() }}</p>
                                    </div>
                                </div>
                                 <div class="form-group">
                                    <div class="col-sm-6" v-bind:class="{ 'has-error': errors.firstname !== undefined && errors.firstname.length }">
                                        <input type="text"
                                                v-model="form.firstname"
                                                class="form-control input-sm"
                                                placeholder="Prénom"
                                        >
                                        <p v-if="errors.firstname !== undefined" class="help-block">{{ errors.firstname.join() }}</p>
                                    </div>
                                    <div class="col-sm-6" v-bind:class="{ 'has-error': errors.name !== undefined && errors.name.length }">
                                        <input type="text"
                                                v-model="form.name"
                                                class="form-control input-sm"
                                                placeholder="Nom de la startup / projet"
                                        >
                                        <p v-if="errors.name !== undefined" class="help-block">{{ errors.name.join() }}</p>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-6" v-bind:class="{ 'has-error': errors.email !== undefined && errors.email.length }">
                                        <input type="text"
                                                v-model="form.email"
                                                class="form-control input-sm"
                                                placeholder="Email"
                                        >
                                        <p v-if="errors.email !== undefined" class="help-block">{{ errors.email.join() }}</p>
                                    </div>
                                    <div class="col-sm-6" v-bind:class="{ 'has-error': errors.mobile !== undefined && errors.mobile.length }">
                                        <input type="text"
                                                v-model="form.mobile"
                                                class="form-control input-sm"
                                                placeholder="N° de mobile"
                                        >
                                        <p v-if="errors.mobile !== undefined" class="help-block">{{ errors.mobile.join() }}</p>
                                    </div>
                                </div>
                                 <div class="form-group" v-bind:class="{ 'has-error': errors.problem !== undefined && errors.problem.length }">
                                    <div class="col-sm-12">
                                        <textarea type="text"
                                                v-model="form.problem"
                                                class="form-control input-sm"
                                                placeholder="Quel problème êtes-vous en train de résoudre ?"
                                        ></textarea>
                                        <p v-if="errors.problem !== undefined" class="help-block">{{ errors.problem.join() }}</p>
                                    </div>
                                </div>
                                 <div class="form-group" v-bind:class="{ 'has-error': errors.business_model !== undefined && errors.business_model.length }">
                                    <div class="col-sm-12">
                                        <textarea type="text"
                                                v-model="form.business_model"
                                                class="form-control input-sm"
                                                placeholder="Quel est votre business model ?"
                                        ></textarea>
                                        <p v-if="errors.business_model !== undefined" class="help-block">{{ errors.business_model.join() }}</p>
                                    </div>
                                </div>
                                 <div class="form-group" v-bind:class="{ 'has-error': errors.team !== undefined && errors.team.length }">
                                    <div class="col-sm-12">
                                        <textarea type="text"
                                                v-model="form.team"
                                                class="form-control input-sm"
                                                placeholder="Quelle est l’équipe actuellement en place ?"
                                        ></textarea>
                                        <p v-if="errors.team !== undefined" class="help-block">{{ errors.team.join() }}</p>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <div class="col-sm-offset-2 col-md-offset-4 col-sm-4 col-md-4">
                                            <button class="ns-btn ns-btn-yel">SOUMETTRE LA DEMANDE</button>
                                        </div>
                                    </div>
                                     <div class="success-message" v-if="sentSuccess">Your message has been sent successfully. </div>
                                </div>
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <ad></ad>
            </div>
        </div>
    </div>
    </div>
</template>

<script type="text/babel">
    import ad from '../../components/ad.vue';

    export default {
        data() {
            return {
                form: {},
                errors: {},
                loading: false,
                sentSuccess: false
            }
        },
        created() {
        },
        computed: {
            user() {
                return this.$store.getters.user;
            }
        },
        methods: {
            submit() {
                this.loading = true;
                this.sentSuccess = false;

                this.$http.post('/api/customer-support/fundraising', this.form).then(response => {
                    this.form = {};
                    
                    this.errors = {};
                    this.sentSuccess = true;
                }, response => {
                    this.errors = response.data;
                }).finally(() => {
                    this.loading = false;
                    this.submitting = false;
                })
            }
        },
        components: {
            ad
        }
    }
</script>

<style>
.header {
    text-align: center;
    font-weight: bold;
    font-size: 18px;
    margin: 10px 0 0 0;
}

.title-item {
    text-align: center;
}

.list li::before {
    content: "• ";
    color: black;
}
</style>