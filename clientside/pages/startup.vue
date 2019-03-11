<template>
    <div class="content-wrapper">
        <div class="jumbotron static-header">
            <div class="container wrap-jumbotron">
                <h1 class="title-item none-overflow">
                     
                    
                    <router-link to="/startups/create" class="ns-btn btn-sm ns-btn-ghost-yel" style="max-width:250px">
                        Submit a similar start-up
                    </router-link>
                </h1>
            </div>
        </div>
        <div class="container wrap-ui">
            <div class="row">
                <div class="col-md-8">
                    <startup-description v-bind:data="startup" v-bind:loading="loading"></startup-description>
                     <div class="notification success" v-if="isSendSuccessfully">
                        <span class="title">: )&nbsp;&nbsp;&nbsp;&nbsp;Success</span> Contact was sent successfully!<span class="close" v-on:click="hideNotification()">X</span>
                    </div>
                    <contacts-list v-if="!loading && startup" v-bind:startup="startup" v-on:contactSend="oncontactSend"></contacts-list>
                </div>
                <div class="col-md-4">
                    <div class="responsive-side collapse">
                        <startup-author v-bind:data="author" v-bind:loading="loading"></startup-author>
                        <startup-details v-bind:data="startup" v-bind:loading="loading"></startup-details> 
                        <ad></ad>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script type="text/babel">
    import startupDescription from '../components/startup/description.vue';
    import contactsList from '../components/startup/contacts-list.vue';
    import startupAuthor from '../components/startup/author.vue';
    import startupDetails from '../components/startup/details.vue';
    import ad from '../components/ad.vue';

    export default {
        data() {
            return {
                loading: true,
                startup: null,
                isSendSuccessfully: false
            }
        },
        created() {
            if (!this.auth) {
                var token = this.$route.query.token;
                var slug = this.$route.params.slug;

                var obj = {
                    path: `/login`
                };

                obj['query'] = {caller: `/startups/${slug}`};

                if (token) {
                    obj['query']['token'] = token;
                    this.$router.push(obj);
                    return;
                }
            }
            setTimeout(() => {
                this.load();
            }, 0);
            },
        computed: {
            author() {
                if(this.startup) {
                    return this.startup.author;
                } else {
                    return null;
                }
            },
            auth() {
                return this.$store.getters.auth;

            },
            user() {
                return this.$store.getters.user;
            }
        },
        methods: {
            load() {
                this.loading = true;

                this.$http.get(`/api/startups/${ this.$route.params.slug }`).then(response => {
                    this.startup = response.data;
                    this.checkTeamMember(this.startup);
                }, response => {
                    //
                }).then(() => {
                    this.loading = false;
                });
            },
            onContactCreated(contact) {
                this.startup.applied = true;
                this.startup.contacts.unshift(contact);
            },
            checkTeamMember(data) {
                var token = this.$route.query.token;

                if (!token) {
                    return true;
                }

                var teams = data.teams;
                if (!teams || teams.length === 0) {
                    this.$router.push('/');
                    return false;
                }

                var len = teams.length;
                var member = null;

                for (var i = 0; i < len; i++) {
                    if (teams[i].email === this.user.email) {
                        member = teams[i];
                        break;
                    }
                }

               if (!member) {
                   this.$router.push('/');
                   return false;
               }

               // Already belong team
               if (member.active === 1) {
                   return true;
               }

               if (!token) {
                   this.$router.push('/');
                   return false;
               }

                var token = this.$route.query.token;
                this.$http.post('/api/team/joinTeam', {
                    start_up_id: data.id,
                    token: token
                }).then(response => {
                    data.teams[i] = response.data.member;
                    // this.$router.push(`/startups/${data.slug}`);
                    location.reload();
                },
                response => {
                    this.$router.push('/');
                    return false;
                });
            },
            oncontactSend(isSuccess) {
                this.isSendSuccessfully = isSuccess;
            },
            hideNotification() {
                this.isSendSuccessfully = false;
            }
        },
        components: {
            'startup-description': startupDescription,
            'startup-author': startupAuthor,
            'startup-details': startupDetails,
            'ad': ad,
            'contacts-list': contactsList
        }
    }
</script>
<style>
html,body{
	padding: 0;
	margin: 0;
	font-family: 'Ubuntu', sans-serif;
}

.notification{
	width: 60vw;
	height: 40px;
	border-radius: 0px 0px 5px 5px;
	margin: 0 auto;
	box-shadow: #95a5a6 0px 0px 6px 2px;
	color: white;
	line-height: 40px;
	overflow: hidden;
	animation: reveal 1 2s;
}
.notification .title{
	margin-right: 15px;
	padding: 0px 15px;
	line-height: 40px;
	display: inline-block;
}

.notification .close{
	background: rgba(255,255,255,0.2);
	padding: 0px 15px;
	float: right;
	line-height: 40px;
	display: inline-block;
	color: white;
}
.notification .close:hover{
  cursor: pointer;
}
.notification.closed{
	transform: translate(0px, -50px);
	transition: 0.7s;
}

@keyframes reveal{
	0%{
		transform: translate(0px, -50px);
	}
	50%{
		transform: translate(0px, -50px);
	}
	100%{
		transform: translate(0px, 0px);
	}
}


.notification.success{
	background: #2ecc71;
}
.notification.success .title{
	background: #27ae60;
}

.notification.error{
	background: #e74c3c;
}
.notification.error .title{
	background: #c0392b;
}

.notification.warning{
	background: #f1c40f;
}
.notification.warning .title{
	background: #f39c12;
}

.notification.normal{
	background: #3498db;
}
.notification.normal .title{
	background: #2980b9;
}
</style>