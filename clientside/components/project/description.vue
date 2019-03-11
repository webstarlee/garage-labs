<template>
    <div class="panel panel-default">
        <div v-if="loading" class="text-center" style="padding: 200px 0">
            <i class="fa fa-spinner fa-spin fa-3x fa-fw"></i>
        </div>
        <div v-if="!loading">
            <div class="panel-heading grid-panel-title">
                <h1 class="title-shot">{{ data.title | capitalize }}</h1>
                <span class="btn-block subtitle-shot col-thumb" style="font-size:14px;">By
                    <router-link v-bind:to="`/users/${ data.author_id }`">{{ data.author.first_name }} {{ data.author.last_name }}</router-link>
                    <span class="ic-sep">|</span>
                    <span v-bind:class="{ 'text-danger': data.status === 'closed', 'text-success': data.status === 'opened' }">{{ data.status | capitalize }}</span>
                    <template v-if="auth && user.id === data.author_id">
                        <span class="ic-sep">|</span>
                        <router-link v-bind:to="`/projects/${ data.slug }/edit`">Editer</router-link>
                    </template>
                    <span style="margin-left: 100px;">
                        <span class="ns-icon ns-icon-16"><img src="/vendor/img/custom-icon/ic-dollar.png" alt=""></span> 
                        <span>
                            Budget: {{ data.budget }} €
                        </span>
                        <span style="margin-left: 10px;">
                            <span class="ns-icon ns-icon-16">
                                <img src="/vendor/img/custom-icon/ic-clock-16.png" alt="">
                            </span>
                            <font color="green">Open</font>
                            {{ data.created_at | moment("from") }}
                        </span>
                    </span>
                </span>
               
            </div>

            <!-- <div class="position-relative">
                <div class="btn-block shot-view; ">
                    <div style="align:left; margin-left:15px; margin-top:10px; margin-right:5px; white-space: pre-wrap; word-wrap: break-word; font-family: inherit;">{{ data.description }}</div>
                </div>
            </div> --> 
            <div class="panel-body">
                <div class=" btn-block pull-left text-left">
                    <img src="/vendor/img/custom-icon/ic-tag-16.png" width="16">
                    <span class="subtitle-section">{{projectDetailConfig.skill_technology}}</span> 
                    <div class="section-description">
                      <span style="margin-right: 5px;"v-for="cat in data.categories" class="btn btn-tag btn-xs">{{ cat.name }}, </span> 
                    </div>
                </div>
                 <div class="btn-block pull-left text-left">
                  <img src="/vendor/img/custom-icon/ic-info.png" width="16">
                    <span class="subtitle-section">{{projectDetailConfig.description}}</span> 
                    <div class="section-description">
                        {{ data.description }}
                    </div>
                </div>
                <div class="btn-block pull-left text-left">
                  <img src="/vendor/img/custom-icon/ic-clock-16.png" width="16">
                    <span class="subtitle-section">{{projectDetailConfig.project_begin}}</span> 
                    <div class="section-description">
                        {{ data.starts_at | moment('from') }}
                    </div>
                </div>
                <div class="btn-block pull-left text-left">
                  <img src="/vendor/img/custom-icon/ic-clock-16.png" width="16">
                    <span class="subtitle-section">{{projectDetailConfig.project_end}}</span> 
                    <div class="section-description">
                        {{ data.ends_at | moment('from') }}
                    </div>
                </div>

                <!-- <div class=" btn-block pull-left text-left">
                    <img src="/vendor/img/start.svg" width="16"> Le projet commence  {{ data.starts_at | moment('from') }}
                </div>
                <div class="btn-block pull-left text-left">
                    <img src="/vendor/img/finish.svg" width="16"> Le projet se termine {{ data.ends_at | moment('from') }}<br><br>
                </div> -->
                <template v-if="data.documents.length">
                    <h4>
                        <strong><i class="icon-attachment myicon-right"></i> Pièces jointes</strong>
                    </h4>
                    <a target="_blank"
                       v-for="document in data.documents"
                       v-bind:href="document.url"
                       class="btn-default btn-xs btn-border btn-block pull-left text-left fileContainer"
                       style="display: block; padding: 10px;"
                    >
                        <i style="font-size: 130%; margin-right: 5px;" class="fa fa-file" aria-hidden="true"></i>
                        <span class="myicon-right file-name-file">{{ document.filename }}</span>
                    </a>
                </template>
            </div>
        </div>
    </div>
</template>

<script>

   
   
   
    export default {
        props: ['data', 'loading'],
        computed: {
            auth() {
                return this.$store.getters.auth;
            },
            user() {
                return this.$store.getters.user;
            }
        },
         data() {
            return {
                projectDetailConfig: {}
            }
        },
        created() {
            this.fetchContentEn();
        },
        methods: {
            fetchContentEn() {
                this.$http.get('/data/content_en.json').then(response => {
                    this.projectDetailConfig = response.body.project_detail;
                }, response => {
                    console.log(response);
                });
            }
        }
    }
    
</script>