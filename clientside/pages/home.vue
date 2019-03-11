<template>
    <div class="movetotop" v-if="menuConfig && menuConfig.start">
        <div class="jumbotron index-header home-wrapper">
            <h2 class="ns-jumbotron-title text-center" v-if="this.$route.query.type==='startups' || this.$route.query.type==='cofounders' || !this.$route.query.type">
                {{menuConfig.start.title}}
            </h2>
            <h2 class="ns-jumbotron-title text-center" v-if="this.$route.query.type==='project' || this.$route.query.type==='service'">
                {{menuConfig.build.title}}
            </h2>
            <h2 class="ns-jumbotron-title text-center" v-if="this.$route.query.type==='grow'">
                {{menuConfig.grow.title}}
            </h2>
            <div class="container ns-jumbotron-actions" v-if="this.$route.query.type==='project' || this.$route.query.type==='service'">
                <div class="col-sm-offset-2 col-md-offset-3 col-sm-4 col-md-3">
                    <router-link to="/projects/create" href="" class="ns-btn ns-btn-ghost-yel">{{menuConfig.build.buttons[0]}}</router-link>
                </div>
                <div class="col-sm-4 col-md-3">
                    <a href="/?type=service" class="ns-btn ns-btn-ghost-yel">{{menuConfig.build.buttons[1]}}</a>
                </div>
            </div>
            <div class="container ns-jumbotron-actions" v-if="this.$route.query.type==='startups' || this.$route.query.type==='cofounders' || !this.$route.query.type">
                <div class="col-sm-offset-2 col-md-offset-4 col-sm-4 col-md-4">
                    <router-link to="/startups/create" href="" class="ns-btn ns-btn-ghost-yel">{{menuConfig.start.buttons[0]}}</router-link>
                </div>
            </div>
            <div class="container ns-jumbotron-actions" v-if="this.$route.query.type==='grow'">
                <div class="col-sm-offset-2 col-md-offset-3 col-sm-4 col-md-3">
                    <router-link to="/startups/create?type=investisseur" class="ns-btn ns-btn-ghost-yel">{{menuConfig.grow.buttons[0]}}</router-link>
                </div>
                <div class="col-sm-5 col-md-4">
                    <router-link to="/accompany" class="ns-btn ns-btn-ghost-yel">{{menuConfig.grow.buttons[1]}}</router-link>
                </div>
            </div>
        </div>
        <div>
            <div class="container wrap-ui">
                <div class="row">
                    <div class="col-md-12">
                        <project-search />
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import projectSearch from '../components/project-search.vue';

    export default {
        components: {
            'project-search': projectSearch
        },
        data() {
            return {
                menuConfig: {}
            }
        },
        created() {
            this.fetchContentEn();
        },
        methods: {
            fetchContentEn() {
                this.$http.get('/data/content_en.json').then(response => {
                    this.menuConfig = response.body.menu;
                }, response => {
                    console.log(response);
                });
            }
        }
    }
</script>