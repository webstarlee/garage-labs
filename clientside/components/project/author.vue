<template>
    <div class="panel panel-default">
        <div v-if="loading" class="text-center" style="padding: 100px 0;">
            <i class="fa fa-spinner fa-spin fa-3x fa-fw"></i>
        </div>
        <div v-else class="panel-body padding-top padding-top-zero padding-right-zero padding-left-zero">
            <!-- <div v-bind:style="`background: url(${ data.cover_path }) no-repeat center center #0088E2; background-size: cover;`" class="cover-wall"></div> -->
            <div class="media media-visible pd-right">
                <router-link v-bind:to="`/users/${ data.id }`" class="btn-block photo-card-live myprofile">
                    <img class="border-image-profile img-circle photo-card"
                         alt="Image"
                         v-bind:src="data.avatar_path"
                         width="80"
                         height="80"
                    >
                </router-link>
                <div class="media-body">
                    <h4 class="user-name-profile-card btn-block text-center" style="margin-top: 0;">
                        <router-link class="myprofile" v-bind:to="`/users/${ data.id }`">
                            <span class="none-overflow">{{ data.first_name }} {{ data.last_name }}</span>
                        </router-link>
                    </h4>
                    <div class="btn-block text-center col-thumb" style="margin-top:-5px; ">
                        <template>@{{data.username}}<br/></template>
                        <template v-if="data.city || data.country">
                            <i class="glyphicon glyphicon-map-marker"></i> {{ data.city ? data.city.name : '' }}, {{ data.country ? data.country.name : '' }}<br>
                        </template>
                        <template v-if="data.displaying_i_am">
                            {{data.displaying_i_am}}<br>
                        </template>
                        <template>{{ data.created_at | moment("from") }}</template>
                        <template v-if="auth && user.id !== data.id">
                            <template v-if="auth">
                                <template v-if="data.contact_link">
                                    <router-link v-bind:to="data.contact_link"
                                                 class="btn btn-default btn-xs btn-follow myicon-right shotTooltip"
                                                 style="margin-top:5px">
                                        <i class="glyphicon glyphicon-plus myicon-right"></i> Contact
                                    </router-link>
                                </template>
                                <template v-else>
                                    You are not connected.
                                </template>
                            </template>
                            <template v-else>
                                To make a proposal, you must be logged in.
                            </template>
                        </template>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        computed: {
            user() {
                return this.$store.getters.user;
            },
            auth() {
                return this.$store.getters.auth;
            }
        },
        props: ['loading', 'data']
    }
</script>