<template>
    <div class="menu-wrapper"  v-if="menu.build">
        <div class="navbar navbar-inverse">
            <div class="container">
                <div class="navbar-header col-md-2">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a href="javascript:void(0)" v-on:click="searchAll()" class="navbar-brand">
                        <img width="100%" class="hidden-sm" src="/vendor/img/phase2-icons/logo-header2.png" style="margin-top:-5px">
                        <img width="100%" class="visible-sm-block" src="/vendor/img/custom-icon/logo-sm.png" style="margin-top:-5px">
                    </a>
                </div><!-- navbar-header -->
                <div class="navbar-collapse collapse">
                    
                    <ul class="nav navbar-nav navbar-right-wrapper col-md-10">
                        <li v-bind:class="{'start-active-background': selectedItem === 'start'}">
                            <a href="javascript:void(0)" v-on:click="searchStartUps()">
                             <span class="ns-navbar-icon">
                                <img src="/vendor/img/custom-icon/ic-light-inv.png" v-show="selectedItem === 'start'"/>
                                <img src="/vendor/img/custom-icon/ic-light.png" v-show="selectedItem !== 'start'" />
                             </span>
                               {{menu.start ? menu.start.text : ''}} 
                            </a>
                        </li>
                        <li v-bind:class="{'build-active-background': selectedItem === 'build'}">
                            <a href="javascript:void(0)" v-on:click="searchProjects()">
                             <span class="ns-navbar-icon">
                                <img src="/vendor/img/custom-icon/ic-settings-inv.png" v-show="selectedItem === 'build'"/>
                                <img src="/vendor/img/custom-icon/ic-settings.png" v-show="selectedItem !== 'build'" />
                             </span>
                                {{menu.build ? menu.build.text : ''}} 
                            </a>
                        </li>
                        <!-- <li v-bind:class="{ 'active': this.$route.path === '/' && this.$route.query.type === 'mission' }">
                            <a href="javascript:void(0)" v-on:click="searchMissions()">Missions</a>
                        </li> -->
                        <li v-bind:class="{'grow-active-background': selectedItem === 'grow'}">
                            <a href="javascript:void(0)" v-on:click="searchStartUpsForInvestor()">
                            <span class="ns-navbar-icon">
                                <img src="/vendor/img/custom-icon/ic-startup-inv.png" v-show="selectedItem === 'grow'"/>
                                <img src="/vendor/img/custom-icon/ic-startup.png" v-show="selectedItem !== 'grow'" />
                             </span>
                                {{menu.grow ? menu.grow.text : ''}}
                            </a>
                        </li>
                        <!-- <li v-bind:class="{ 'active': this.$route.path === '/projects/create' }" v-if="auth === true">
                            <router-link to="/projects/create">+ déposer un projet/mission</router-link>
                        </li> -->
                        <template v-if="auth === true">
                            <li v-bind:class="{ 'active': this.$route.path === '/user/messages' }">
                                <router-link to="/user/messages" class="messages" title="Messages">
                                <span class="notify" id="noti_msg"></span>
                                    <span class="fa fa-envelope"></span> <span class="title-dropdown">Messages</span>
                                    <span v-show="unreadMessages > 0" class="badge">{{ unreadMessages }}</span>
                                </router-link>
                            </li>
                            <li v-on:click="fetchNotifications()" class="dropdown">
                                <a href="javascript:void(0)" data-toggle="dropdown">
                                    <span class="notify " id="noti_connect"></span>
                                    <span class="fa fa-bell"></span> <span class="title-dropdown">Notifications</span>
                                    <span v-show="unreadNotifications > 0" class="badge">{{ unreadNotifications }}</span>
                                </a>
                                <ul v-on:click.stop class="dropdown-menu notifications-list" role="menu">
                                    <li v-for="notification in notifications" class="notification-item">
                                        <div class="left">
                                            <template v-if="notification.link !== null">
                                                <a class="content notification-row" v-bind:href="`${ notification.link }`">
                                                    <strong>{{ notification.title }}</strong>
                                                    <p>{{ notification.message }}</p>
                                                </a>
                                            </template>
                                            <template v-else>
                                                <div class="content notification-row">
                                                    <strong>{{ notification.title }}</strong>
                                                    <p>{{ notification.message }}</p>
                                                </div>
                                            </template>
                                        </div>
                                        <div>
                                            <a href="javascript:void(0);" v-on:click="removeNotification(notification.id)">
                                                <img src="/vendor/img/close.png" />
                                            </a>
                                        </div>
                                    </li>
                                    <li v-if="notifications.length > 0" class="see-all-wrapper">
                                        <router-link :to="'/user/notifications'">See all</router-link>
                                    </li>
                                    <li class="text-center" v-if="! notificationsLoading && notifications.length === 0">
                                        <p class="text-grey content">No notification</p>
                                    </li>
                                    <li class="text-center" v-if="notificationsLoading">
                                        <i class="fa fa-spinner fa-spin fa-3x fa-fw"></i>
                                    </li>
                                </ul>
                            </li>
                            <li class="dropdown user">
                                <a href="javascript:void(0);" data-toggle="dropdown" class="userAvatar myprofile dropdown-toggle">
                                    <img v-bind:src="user.avatar_path" alt="User" class="img-circle" width="20" height="20">
                                    <span class="title-dropdown">
                                        My profile
                                    </span>
                                </a>
                                <ul class="dropdown-menu dropdown-nav-session" role="menu" aria-labelledby="dropdownMenu4">
                                    <li class="li-group-nav">
                                        <router-link v-on:click="openNotifications = false;"
                                                    v-bind:to="`/users/${ user.id }`"
                                                    class="myprofile text-overflow"
                                        >
                                            <i class="glyphicon glyphicon-user myicon-right"></i>
                                            {{ user.username }}
                                        </router-link>
                                    </li>
                                    <li class="li-group-nav"><router-link to="/user/profile"><i class="glyphicon glyphicon-cog myicon-right"></i> My parameters</router-link></li>
                                    <li><a href="#" @click="logout()" class="logout"><i class="glyphicon glyphicon-log-out myicon-right"></i> Disconnect</a></li>
                                </ul>
                            </li>
                        </template>
                        <template v-else>
                             <li class="">
                                <router-link to="/register" class="signup">
                                 <span class="ns-navbar-icon">
                                    <img src="/vendor/img/custom-icon/ic-note.png" />
                                 </span>
                                 {{menu.inscription ? menu.inscription.text : ''}}
                                </router-link>
                            </li>
                            <li class="dropdown">
                                <router-link to="/login" class="log-in">
                                 <span class="ns-navbar-icon">
                                    <img src="/vendor/img/custom-icon/ic-login.png" />
                                 </span>
                                 {{menu.login ? menu.login.text : ''}}
                                </router-link>
                            </li>
                        </template>
                    </ul>
                </div><!--/.navbar-collapse -->
            </div>
        </div>
        <div class="sub-header start-active-background" v-if="selectedItem==='start'">
            <router-link  to="/startups/create" >{{menu.start.links_1}}</router-link>
            <a href="javascript:void(0)" v-on:click="searchStartUps()">{{menu.start.links_2}}</a>
            <a href="javascript:void(0)" v-on:click="searchCoFounders()">{{menu.start.links_3}}</a>
        </div>
        <div class="sub-header build-active-background" v-if="selectedItem==='build'">
            <router-link to="/projects/create" >{{menu.build.links_1}}</router-link>
            <a href="javascript:void(0)" v-on:click="searchProjects()" >{{ menu.build.links_2}}</a>
            <a href="javascript:void(0)" v-on:click="searchServices()">{{menu.build.links_3}}</a>
            <router-link to="/service/create" >{{menu.build.links_4}}</router-link>
        </div>
        <div class="sub-header grow-active-background" v-if="selectedItem==='grow'">
            <router-link to="/accompany">{{menu.grow.links_1}}</router-link>
            <a href="javascript:void(0)" v-on:click="searchStartUpsForInvestor()">{{menu.grow.links_2}}</a>
        </div>
    </div>
</template>

<script type="text/babel">
(function(i, s, o, g, r, a, m) {
  i["GoogleAnalyticsObject"] = r;
  (i[r] =
    i[r] ||
    function() {
      (i[r].q = i[r].q || []).push(arguments);
    }),
    (i[r].l = 1 * new Date());
  (a = s.createElement(o)), (m = s.getElementsByTagName(o)[0]);
  a.async = 1;
  a.src = g;
  m.parentNode.insertBefore(a, m);
})(
  window,
  document,
  "script",
  "https://www.google-analytics.com/analytics.js",
  "ga"
);
ga("create", "UA-88266145-1", "auto");
ga("send", "pageview");

export default {
  data() {
    return {
      keyword: "",
      openNotifications: false,
      unreadMessages: 0,
      unreadNotifications: 0,
      notificationsLoading: false,
      notificationsLoaded: false,
      notifications: [],
      fetchInterval: 30000, // 30 seconds
      intervalId: null,
      selectedItem: "",
      menu: {}
    };
  },
  created() {
    if (this.auth) {
      this.fetchUnreadMessages();
      this.fetchUnreadNotifications();

      this.intervalId = this.fetchByInterval();
      let params = this.$route.query;
      switch (params.type) {
        case "project":
        case "service":
          this.selectedItem = "build";
          break;
        case "grow":
          this.selectedItem = "grow";
          break;
        default:
          this.selectedItem = "start";
          break;
      }
    }

    this.fetchContentEn();
  },
  computed: {
    auth() {
      return this.$store.getters.auth;
    },
    user() {
      return this.$store.getters.user;
    }
  },
  watch: {
    auth: function(newValue, oldValue) {
      if (newValue !== oldValue && newValue === true) {
        this.fetchUnreadMessages();
        this.fetchUnreadNotifications();

        this.intervalId = this.fetchByInterval();
      } else {
        clearInterval(this.intervalId);
        this.intervalId = null;
      }
    }
  },
  methods: {
    searchAll() {
      if (this.$route.path === "/") {
        this.$events.emit("searchAllFired", this.keyword);
      }
      this.$router.push("/");
    },
    searchByKeyword() {
      if (this.$route.path === "/") {
        this.$events.emit("searchByKeywordFired", this.keyword);
      }
      this.$router.push(`/?keyword=${this.keyword}`);
    },
    searchMissions() {
      if (this.$route.path === "/") {
        this.$events.emit("searchMissionsFired");
      }
      this.$router.push("/?type=mission");
    },
    searchProjects() {
      this.selectedItem = "build";
      if (this.$route.path === "/") {
        this.$events.emit("searchProjectsFired");
      }
      this.$router.push("/?type=project");
    },
    searchServices() {
      this.selectedItem = "build";
      if (this.$route.path === "/") {
        this.$events.emit("searchServicesFired");
      }
      this.$router.push("/?type=service");
    },
    searchStartUps() {
      this.selectedItem = "start";
      if (this.$route.path === "/") {
        this.$events.emit("searchStartUpsFired");
      }

      this.$router.push("/?type=startups");
    },
    searchStartUpsForInvestor() {
      this.selectedItem = "grow";

      if (this.$route.path === "/") {
        this.$events.emit("searchStartUpsForInvestorFired");
      }

      this.$router.push("/?type=grow");
    },
    searchCoFounders() {
      // this.selectedItem = 'grow';
      if (this.$route.path === "/") {
        this.$events.emit("searchCoFoundersFired");
      }

      this.$router.push("/?type=cofounders");
    },
    fetchByInterval() {
      return setInterval(() => {
        this.fetchUnreadMessages();
        this.fetchUnreadNotifications();
      }, this.fetchInterval);
    },
    fetchNotifications() {
      if (this.notificationsLoaded === true && this.unreadNotifications === 0) {
        return;
      }

      this.notificationsLoading = true;

      this.$http
        .get("/api/notifications")
        .then(response => {
          this.notifications = response.data;
          this.unreadNotifications = 0;
        })
        .finally(() => {
          this.notificationsLoading = false;
          this.notificationsLoaded = true;
        });
    },
    logout() {
      this.$store.commit("logout");
      this.$router.push("/");
    },
    fetchUnreadMessages() {
      this.$http.get("/api/messages/unread").then(
        response => {
          this.unreadMessages = response.data.messages;
        },
        response => {
          console.log(response);
        }
      );
    },
    fetchUnreadNotifications() {
      this.$http.get("/api/notifications/unread").then(
        response => {
          this.unreadNotifications = response.data.notifications;
        },
        response => {
          console.log(response);
        }
      );
    },
    removeNotification(id) {
      this.notificationsLoading = true;

      this.$http
        .post("/api/notifications/remove", { id: id })
        .then(
          response => {
            this.notifications = response.data;
          },
          error => {
            alert(response.data);
          }
        )
        .finally(() => {
          this.notificationsLoading = false;
        });
    },
    fetchContentEn() {
      this.$http.get("/data/content_en.json").then(
        response => {
          this.menu = response.body.menu;
        },
        response => {
          console.log(response);
        }
      );
    }
  }
};
</script>

<style scoped>
.menu-wrapper {
  position: fixed;
  width: 100%;
  z-index: 1000;
  top: 0;
}
.notifications-list {
  width: 300px;
  padding-top: 15px !important;
}

.navbar-inverse .navbar-nav > .open > .dropdown-menu > li > .content,
.notifications-list li .content {
  padding: 15px 15px 15px 0;
}

.navbar-inverse .navbar-nav > .open > .dropdown-menu.notifications-list {
  padding: 0;
  border: none;
}

.navbar-inverse .navbar-nav > .open > .dropdown-menu > li > a {
  padding: 0;
}

.navbar-inverse .navbar-nav > .user.open > .dropdown-menu > li > a {
  padding: 6px 10px;
}

.notifications-list li a {
  padding: 0;
  white-space: pre-wrap;
  white-space: -moz-pre-wrap;
  white-space: -pre-wrap;
  white-space: -o-pre-wrap;
  word-wrap: break-word;
}

.notifications-list li p.content {
  padding: 6px 15px;
}

.dropdown-menu li > a:before,
.dropdown-menu li > a:after {
  content: "";
}

.notifications-list p {
  margin: 0;
}

.navbar-toggle {
  margin: 0;
}

.notification-row:hover {
  color: #ffd700 !important;
}

.notification-item {
  display: flex;
  align-items: center;
  padding-left: 10px;
}

.notification-item .left {
  width: 80%;
}

.see-all-wrapper {
  text-align: center;
  padding-bottom: 15px;
}

.see-all-wrapper a {
  color: blue !important;
}

.see-all-wrapper a:hover {
  color: #ffd700 !important;
}
</style>