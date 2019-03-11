<template>
    <div class="panel container" style="padding-left: 18px;">

        <div class="panel-header">
            <h1 class="title-shots">
                <router-link  v-if="data.type && data.type!=='startups'" title="Sachin" class="item-link" v-bind:to="`/projects/${ data.slug }`">{{ data.title }}</router-link>
                <router-link  v-if="data.type && data.type==='startups'" title="Sachin" class="item-link" v-bind:to="`/startups/${ data.slug }`">{{ data.title }}</router-link>
            </h1>
            <div class="project-tags">
                <span class="ns-icon ns-icon-16">
                    <img src="/vendor/img/custom-icon/ic-tag-16.png" alt="">
                </span>
                    <button style="margin-right: 5px;" v-for="tag in data.tags" class="btn btn-tag btn-xs">{{ tag.name }}, </button>
            </div>
            <div class="project-stats">
                <ul class="list-inline">
                    <li>
                        <span class="ns-icon ns-icon-16">
                            <img src="/vendor/img/custom-icon/ic-dollar.png" alt="">
                        </span>
                        <span>
                           Budget: {{ data.budget }} €
                        </span>   
                    </li>
                    <li>
                        <span class="ns-icon ns-icon-16">
                            <img src="/vendor/img/custom-icon/ic-clock-16.png" alt="">
                        </span>
                        <font color="green">Open</font>
                        {{ data.created_at | moment("from") }}
                    </li>
                    <li>
                        <span class="ns-icon ns-icon-16">
                            <img src="/vendor/img/custom-icon/ic-eye-16.png" alt="">
                        </span>
                        {{ data.views }} <span v-if="data.views > 1"> views</span><span v-else> view</span>
                    </li>
                 </ul>
            </div>
        </div>
        
        <div class="panel-body" style="padding-left:0;">
            <div class="project-desc">
                <p>
                    {{data.description}}
                </p>
            </div>
        </div>
        </div>
    
</template>

<script>
    export default {
        props: ['data']
    }
</script>