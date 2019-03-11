<template>
    <div class="container wrap-ui packages-container content-wrapper">
        <div class="row">
            <div class="col-md-4">
                <div class="responsive-side collapse">
                    <user-overview v-bind:data="auth"></user-overview>
                    <account-navigation></account-navigation>
                    <ad></ad>
                </div>
            </div>
            <div class="col-md-8">
                <div class="panel panel-default">
                    <div class="content">
                        <div class="panel-heading center-text">
                            <div>
                                <span class="ns-icon">
                                    <img src="/vendor/img/late_alert_32x32.png" alt="">
                                </span>
                                <span class="bold-text">Customer support</span>
                            </div>
                            <div>A question, problem, a late delivery ?</div>
                            <div>Contact THE GARAGE LABS customer support, we main reply within 24 and 48 hours.</div>
                        </div>
                        <div class="panel-body">
                               <form v-on:submit.prevent="submit()" class="form-horizontal form-account" role="form">
                                    <fieldset v-bind:disabled="loading">
                                        <div class="form-group" v-bind:class="{ 'has-error': errors.reason !== undefined }">
                                            <div class="col-sm-12">
                                                <select v-model="customer_support.reason" class="form-control select-sm input-sm">
                                                    <option v-for="(reason, index) in reasonList" v-bind:value="index">
                                                        {{reason}}
                                                    </option>
                                                </select>
                                                <p v-if="errors.reason !== undefined" class="help-block">{{ errors.reason.join() }}</p>
                                            </div>
                                        </div>
                                        <div class="form-group" v-bind:class="{ 'has-error': errors.order_id !== undefined && errors.order_id.length }">
                                            <div class="col-sm-12">
                                                <input v-model="customer_support.order_id" type="text" name="job_order_id" class="form-control input-sm" placeholder="ORDER #ID">
                                                <p v-if="errors.order_id !== undefined" class="help-block">{{ errors.order_id.join() }}</p>
                                            </div>
                                        </div>
                                        <div class="form-group" v-bind:class="{ 'has-error': errors.comment !== undefined && errors.comment.length }">
                                            <div class="col-sm-12">
                                                <textarea v-model="customer_support.comment"
                                                        class="form-control input-sm"
                                                        style="height: 100px"
                                                        placeholder="Comment(s)/details"
                                                        required
                                                ></textarea>
                                                <p v-if="errors.comment !== undefined" class="help-block">{{ errors.comment.join() }}</p>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                            <button class="ns-btn btn-success" type="submit">SEND THE REQUEST</button>
                                            <div class="success-message" v-if="sentSuccess">Your message has been sent successfully. </div>
                                            </div>
                                        </div>
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
    import accountNavigation from '../components/account-navigation.vue';
    import ad from '../components/ad.vue';
    import userOverview from '../components/user-overview.vue';

    export default {
        data() {
            return {
                customer_support: {
                    reason: 0,
                    order_id: null,
                    comment: null
                },
                loading: false,
                errors: [],
                reasonList: [
                    "My delivery is late and the supplier is not replying",
                    "I'm not satisfied with a delivery",
                    "I have a general question",
                    "I have a technical problem or noticed a bug"
                ],
                sentSuccess: false
            }
        },
        created() {
        },
        computed: {
            auth() {
                return this.$store.getters.user
            }
        },
        components: {
            'ad': ad,
            'account-navigation': accountNavigation,
            'user-overview': userOverview
        },
        methods: {
            submit() {
                this.customer_support.service_id = this.$route.params.id;
                this.customer_support.type = this.$route.params.type;
                this.sentSuccess = false;
                this.loading = true;

                this.$http.post('/api/customer-support', this.customer_support).then(response => {
                    this.customer_support = {
                        reason: 0,
                        order_id: null,
                        comment: null
                    };
                    
                    this.errors = {};
                    this.sentSuccess = true;
                }, response => {
                    this.errors = response.data;
                    this.sentSuccess = false;
                }).finally(() => {
                    this.loading = false;
                })
            }
        }
    }
</script>
<style>
.center-text {
    text-align: center;
}

.bold-text {
    font-weight: bold;
    font-size: 18px;
}

.success-message {
    text-align: center;
    color: #27ad60;
}
</style>