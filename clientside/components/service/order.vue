<template>
   <div>
        <div class="panel panel-default order-container col-md-3" v-for="package in packages">
            <div class="price">{{package.price}}&euro;</div>
            <div class="name">{{package.name}}</div>
            <div class="description">
            {{package.description}}
            </div>
            <div>
                <span>
                    <i class="fa fa-clock-o" aria-hidden="true"></i>
                </span>
                <span>Delivery: {{package.days_to_deliver + (package.days_to_deliver > 1 ? ' days' : ' day')}}</span>
            </div>
            <div>
                <span class="fa fa-refresh"></span>
                <span>Revisions: {{package.number_devisions}}</span>
            </div>
            <div class="order-btn">
                <router-link class="ns-btn ns-btn-yel" v-bind:to="`/order/confirmation/${package.id}`">ORDER</router-link>
            </div>
        </div>
   </div>
</template>

<script>
    export default {
        props: ['packages'],
        data() {
            return {
                avgStars: 0
            }
        },
        methods: {
        },
        components: {
        }
        }
</script>
<style>
.order-container {
    margin: 5px 15px;
}

.order-container .price {
    color: #26cc68;
    font-size: 1.5em;
    margin: 0 !important;
}

.order-container .order-btn {
    margin-top: 10px;
}

.order-container .name {
    text-transform: uppercase;
}
</style>