<template>
    <li class="li-group-msg hoverList">
        <router-link v-bind:to="`/projects/${ data.slug }`" class="see_msg list-group-item border-group">
            <div class="media">
                <div class="media-body clearfix">
                    <div class="pull-right text-right small">
                        <span class="text-success">{{ data.budget }} €</span><br/>
                        <strong class="small">
                            <template v-if="data.status === 'opened'">Open </template>
                            <template v-else>Closed </template>
                        </strong><br/>
                        <small>Type: {{ data.type }}</small>
                    </div>
                    <div class="media-nowrap">
                        <h4 class="media-heading">{{ data.title }}</h4>
                        <small>Created the {{ data.created_at | moment('from') }}</small><br/>
                        <small>{{ data.proposals_count }} propositions</small>
                    </div>
                </div>
            </div>
        </router-link>
    </li>
</template>

<script>
export default {
  props: ["data"]
};
</script>