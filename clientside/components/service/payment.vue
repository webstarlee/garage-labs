<template>
    <div class="position-relative">
            <div class="btn-block">
                <div style="margin-left:15px; margin-top:10px; margin-right:12px">
                    <form v-on:submit.prevent="confirmPayment()">
                        <fieldset v-bind:disabled="submitting || loading">
                            <div class="form-group">
                                <div>Payment</div>
                            </div>
                                <div class="form-group" v-bind:class="{ 'has-error': errors.credit_card !== undefined && errors.credit_card.length }">
                                <div>CREDIT CARD :</div>
                                <div class="">
                                    <!--p  v-if="isLoadCard && author.card_no">VISA {{author.card_no}}</p -->
                                    <select  
                                        v-if="isLoadCard && cards && cards.length > 0" 
                                        v-model="payment.credit_card"
                                        class="input-sm"
                                        style="margin-bottom: 10px">
                                        <option 
                                        v-for="card in cards" 
                                        v-bind:value="card.card_id" 
                                        v-bind:key="card.id"
                                        :selected="author.card_no == card.card_no ? 'selected' : ''">
                                        {{ card.card_no }}
                                        </option>
                                    </select>
                                    <input  required v-model="payment.credit_card" type="text" name="credit_card" class="form-control input-sm" placeholder="6777XXXXXXXXX" v-if="!isLoadCard" />
                                    <p v-if="errors.credit_card !== undefined" class="help-block">{{ errors.credit_card.join() }}</p>
                                </div>
                                <a v-if="isLoadCard" href="javascript:void(0)"v-on:click="addNewCreditCard()"><u>+ Add a new credit card</u></a>
                            </div>
                            <div class="form-group" v-if="!isLoadCard">
                                <div class="row">
                                    <div class="col-md-4" v-bind:class="{ 'has-error': errors.expired !== undefined && errors.expired.length }">
                                        <label>Expired At</label>
                                        <input required v-model="payment.expired" class="form-control input-sm" placeholder="2017/09"/>
                                        <p v-if="errors.expired !== undefined" class="help-block">{{ errors.expired.join() }}</p>
                                    </div>
                                    <div class="col-md-4 col-md-offset-4" v-bind:class="{ 'has-error': errors.cvc !== undefined && errors.cvc.length }">
                                        <label>CVC</label>
                                        <input required v-model="payment.cvc" class="form-control input-sm" placeholder="123" />
                                        <p v-if="errors.cvc !== undefined" class="help-block">{{ errors.cvc.join() }}</p>
                                    </div>
                                </div>
                            </div>
                            <div class="checkbox-wrapper form-group" v-if="!isLoadCard">
                                <input type="checkbox" value="1" v-model="payment.remember"  id="remmeber" />
                                <label for="remmeber">Remember my card for next order(s)</label>
                            </div>
                            <div class="form-group">
                                <button data-toggle="modal" class="ns-btn ns-btn-yel" style="width: 100%;">
                                    CONFIRM PAYMENT
                                </button>
                                <div v-if="submitting" style="padding: 20px 0px;" class="li-group-msg hoverList text-center"><i class="fa fa-spinner fa-spin fa-3x fa-fw"></i></div>
                            </div>
                        </fieldset>
                    </form>
                </div>
            </div>
        </div>
</template>

<script>
    export default {
        props: ['author', 'package'],
        data() {
            return {
               payment: {},
               submitting: false,
               errors: {},
               isLoadCard: false,
               updateCard: false,
               cards: [],
               loading: false
            }
        },
        created() {
            this.fetchCreditCards();
            if (this.author.card_id) {
                this.isLoadCard = true;
                this.payment.credit_card = this.author.card_id;
            }
        },
        methods: {
            addNewCreditCard() {
                this.isLoadCard = false;
                this.payment.credit_card = null;
                this.updateCard = true;
            },
            confirmPayment() {
                this.submitting = true;
                this.errors = {};
                this.$http.post(`/api/services/payment`, {
                    price: this.getPriceWithFee(this.package.price),
                    credit_card: this.payment.credit_card,
                    expired: this.isLoadCard ? '2017/09' : this.payment.expired,
                    cvc: this.isLoadCard ? '123' : this.payment.cvc,
                    remember: this.payment.remember,
                    update_card: this.updateCard,
                    package_id: this.package.id,
                }).then(response => {
                    if (response.body.card !== null) {
                        this.payment.credit_card = response.body.card;
                        this.isLoadCard = true;
                        this.$router.push(`/order/instruction/${response.body.package_order_id}/${this.package.id}`);
                    }
                }, response => {
                    if (response.status === 402) {
                        this.errors.credit_card = [response.body.message];
                    } else {
                        this.errors = response.body;
                    }
                
                }).then(() => {
                    this.submitting = false;
                });
            },
            getPriceWithFee(price) {
                return price + (price * 3.5 / 100);
            },
            fetchCreditCards() {
                this.loading = true;
                this.$http.get('/api/users/credit-cards').then(response => {
                    this.cards = response.data;
                }).finally(() => {
                    this.loading = false;
                });
            }
        }
        }
</script>
<style>
.order-container {
    margin: 15px;
}

.order-container .price {
    color: #26cc68;
}

.order-container .order-btn {
    margin-top: 10px;
}

.order-container .name {
    text-transform: uppercase;
}

.checkbox-wrapper label {
    color: #333;
}
</style>