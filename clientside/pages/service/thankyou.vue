<template>
    <div class="row content-wrapper">
        <div class="col-md-10 col-md-offset-1">
            <h2 class="instruction-header">Order instructions</h2>
            <div class="panel panel-default thank-you-container">
                <h4 class="title">Thanks!<br/>Your order started.</h4>
                <div>
                    Supplier will be notified and you should expect a delivery for {{ getDeliveryDate() | moment("DD MMM YYYY") }}.
                </div>
                 <div>
                    Don't hesitate to contact the supplier for more precisions.
                </div>
                 <div class="author-wrapper">
                    <div class="author">
                        <div class="left-col">
                            <img v-bind:src="author.avatar_path" />
                        </div>
                        <div class="right-col">
                            <div class="name">
                            <router-link v-bind:to="`/users/${ author.id }`" class="btn-block photo-card-live myprofile">
                            {{author.first_name}} {{ author.last_name}}
                            </router-link>
                            </div>
                        </div>
                    </div>
                </div>
                <div>
                    <router-link class="ns-btn ns-btn-yel contact-btn" v-bind:to="`/user/ordered-contact/${ $route.params.ordered_package_id }`">CONTACT</router-link>
                </div>
            </div>
        </div>
    </div>
</template>

<script type="text/babel">
    export default {
        data() {
            return {
                loading: false,
                package: {},
                author: {}
            }
        },
        created() {
            this.getPackageById(this.$route.params.id);
        },
        methods: {
            moment: function () {
                return moment();
            },
            getDeliveryDate() {
                // const days_to_delivery = parseInt(this.package.days_to_deliver);
                let d_date = new Date();
                d_date.setDate(d_date.getDate() + this.package.days_to_deliver);
                console.log(d_date);
                return d_date;
            },
            getPackageById(id) {
                this.$http.get(`/api/services/package/${id}`).then(response => {
                    this.package = response.data.package;
                    this.author = response.data.package.author;
                },
                response => {
                    alert('You cannot make the order for your own package or you are not login yet.');
                    this.$router.push('/');
                }
                )
                .finally(() => {
                    this.loading = false;
                });
            }
        }
    }
</script>
<style>
.thank-you-container {
    margin: 10px;
    text-align: center;
}

.thank-you-container .author {
    display: -webkit-flex;
    display: flex;
    -webkit-flex-flow: row nowrap;
    flex-flow: row nowrap;
    margin: 10px 0;
}
.thank-you-container .author .left-col {
    width: 30px;
}

.thank-you-container .author .left-col img {
    display: inline-block;
    border-radius: 50%;
    height: 30px;
    width: 30px;
}

.thank-you-container .author .right-col {
    margin-left: 5px;
    line-height: 14px;
    display: -webkit-flex;
    display: flex;
    align-items: center;
}
.thank-you-container .author-wrapper {
    display: -webkit-flex;
    display: flex;
    justify-content: center;
}
.thank-you-container .contact-btn {
    width: 100%;
}

@media (min-width: 576px) {
    .thank-you-container .contact-btn {
        width: 20%;
    }
}
</style>