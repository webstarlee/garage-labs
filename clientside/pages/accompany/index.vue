<template>
    <div class="content-wrapper">
        <div class="jumbotron static-header">
            <div class="container wrap-jumbotron">
                <h1 class="title-item none-overflow">
                {{accompanyConfig.title}}
                </h1>
            </div>
        </div>
    <div class="container wrap-ui">
        <div class="row">
            <div class="col-md-offset-2 col-md-8">
                <div class="panel panel-default">
                    <div class="header">
                    {{accompanyConfig.header}}
                    </div>
                    <div class="panel-body">
                        <form class="form-horizontal form-account" role="form">
                            <fieldset>
                                <div class="form-group">
                                   <div class="col-sm-12">
                                    <ul class="list">
                                        <li v-for="item in accompanyConfig.rows">{{item}}</li>
                                    </ul>
                                   </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <div class="col-sm-6">
                                            <router-link v-bind:to="'/accompany/create'" class="ns-btn btn-success">{{accompanyConfig.buttons[0]}}</router-link>
                                        </div>
                                        <div class="col-sm-6">
                                            <router-link to="/startups/create?type=investisseur" class="ns-btn ns-btn-yel">{{accompanyConfig.buttons[1]}}</router-link>
                                        </div>
                                    </div>
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
                accompanyConfig: {}
            }
        },
        created() {
            this.fetchContentEn();
        },
        computed: {
            user() {
                return this.$store.getters.user;
            }
        },
        methods: {
            fetchContentEn() {
                this.$http.get('/data/content_en.json').then(response => {
                    this.accompanyConfig = response.body.accompany;
                }, response => {
                    console.log(response);
                });
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