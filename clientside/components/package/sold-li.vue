<template>
    <div class="panel container package-container">
        <div class="panel-header">
            <div class="project-stats">
                <ul class="list-inline">
                    <li class="id">
                        #{{orderedPackage.id}}
                    </li>
                    <li class="title">
                       <router-link v-if="auth.id===orderedPackage.package.author_id" v-bind:to="`/user/sold-package/${orderedPackage.id}`">{{orderedPackage.package.name}}</router-link>
                       <router-link v-if="auth.id===orderedPackage.buyer_id" v-bind:to="`/user/ordered-package/${orderedPackage.id}`">{{orderedPackage.package.name}}</router-link>
                    </li>
                    <li class="service-title">{{orderedPackage.package.service.title}}</li>
                    <li class="service-client">{{orderedPackage.buyer.username}}</li>
                    <li class="package-price">&euro;{{orderedPackage.package.price}}</li>
                    <li class="expecting-date">
                        {{ getDeliveryDate(orderedPackage) | moment("DD MMM YYYY") }}
                    </li>
                    <li class="status">
                        <div v-if="isLate(orderedPackage)" class="status-bar late">LATE</div>
                        <div v-if="!isLate(orderedPackage) && !isDelivered(orderedPackage)" class="status-bar inprogress">IN PROGRESS</div>
                        <div v-if="isDelivered(orderedPackage)" class="status-bar delivered">DELIVERED</div>
                    </li>
                </ul>
            </div>
        </div>   
    </div>
</template>

<script>
    export default {
        props: ['orderedPackage'],
        methods: {
            getDeliveryDate(orderedPackage) {
                let d_date = new Date(orderedPackage.paying_date);
                d_date.setDate(d_date.getDate() + parseInt(orderedPackage.package.days_to_deliver));
                return d_date;
            },
            isLate(orderedPackage) {
                if (this.isDelivered(orderedPackage)) {
                    return false;
                }
                
                let now = new Date();
                return now > this.getDeliveryDate(orderedPackage);
            },
            isDelivered(orderedPackage) {
                return orderedPackage.status !== 'new';
            },
            moment: function () {
                return moment();
            }
        },
        computed: {
            auth() {
                return this.$store.getters.user
            }
        }
    }
</script>
<style>
.package-header {
    margin-bottom: 5px;
}
.package-container {
    padding-left: 18px;
}

.package-container .list-inline {
    display: flex;
    flex-flow: row nowrap;
}

.package-container .id {
    width: 70px;
}

.package-container .expecting-date {
    min-width: 120px;
    text-align: center;
}

.package-container .title {
    width: 10%;
}

.package-container .service-title {
    width: 25%;
}

.package-container .service-client {
    width: 20%;
}

.package-container .package-price {
    width: 9%;
}

.package-container .action {
    float: right;
    text-align: center;
    font-size: 1.2em;
}

.package-container .action .edit {
    margin-right: 10px;
}

.package-container .status {
    text-align: center;
    min-width: 120px;
}

.package-container .late {
    background-color: #ff2121;
    color: white;
}

.package-container .inprogress {
    background-color: #f2cc59;
}

.package-container .delivered {
    background-color: #81bc5c;
}
</style>