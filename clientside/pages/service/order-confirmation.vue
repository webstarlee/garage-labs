<template>
    <div class="row content-wrapper" v-if="package.id">
        <div class="col-md-10 col-md-offset-1">
            <h2 class="order-header">Order Confirmation</h2>
            <div class="panel panel-default order-container">
                <div class="row">
                    <div class="col-md-6 left-wrapper">
                        <payment v-bind:author="author" v-bind:package="package"></payment>
                    </div>
                     <div class="col-md-6">
                        <div>Order #{{package.id}}</div>
                        <div><h4>{{package.name}}</h4></div>
                        <div>
                            <div>PRICE: <span class="price">{{getPrice(package.price)}}&euro;</span></div>
                            <div>FEES({{ratting}}%): <span class="price">{{getFee(package.price)}}&euro;</span></div>
                            <div>TOTAL: <span class="price">{{getTotal(package.price)}}&euro;</span></div>
                        </div>
                        <div class="name">{{package.name}}</div>
                        <div class="description">
                        {{package.description}}
                        </div>
                        <div>
                            <span>
                                <i class="fa fa-clock-o" aria-hidden="true"></i>
                            </span>
                            <span>Delivery: {{package.days_to_deliver + (days_to_deliver > 1 ? ' days' : ' day')}} ({{ getDeliveryDate() | moment("DD MMM YYYY") }})</span>
                        </div>
                        <div>
                            <span class="fa fa-refresh"></span>
                            <span>Revisions: {{package.number_devisions}}</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script type="text/babel">
    import payment from '../../components/service/payment.vue';

    export default {
        data() {
            return {
                loading: false,
                package: {},
                author: {},
                ratting: 3.5
            }
        },
        created() {
            this.getPackageById(this.$route.params.id);
        },
        components: {
            'payment': payment,
        },
        methods: {
            getPackageById(id) {
                this.$http.get(`/api/services/package/${id}`).then(response => {
                    this.package = response.data.package;
                    this.author = response.data.author;
                },
                response => {
                    alert('You cannot make the order for your own package or you are not login yet.');
                    this.$router.push('/');
                }
                )
                .finally(() => {
                    this.loading = false;
                });
            },
            getDeliveryDate() {
                let d_date = new Date();
                d_date.setDate(d_date.getDate() + this.package.days_to_deliver);
                console.log(d_date);
                return d_date;
            },
            getPrice(price) {
                return price.toFixed(2);
            },
            getFee(price) {
                return (price * this.ratting / 100).toFixed(2);
            },
            getTotal(price) {
                var pr = parseFloat(price.toFixed(2));
                var f = parseFloat((price * this.ratting / 100).toFixed(2));

                return (pr + f).toFixed(2);
            }
        }
    }
</script>
<style>
.order-container {
    margin: 10px;
}

.order-container .left-wrapper {
    border-right: 1px solid #ddd;
}
.order-container .price {
    color: #26cc68;
    margin-top: 20px;
}
.order-container .name {
    text-transform: uppercase;
}
.order-container .description {
    margin-bottom: 20px;
}
.order-header {
    text-align: center;
}

.checkbox-wrapper label {
    margin-top: auto;
}
</style>