import Login from './pages/login.vue';
import Register from './pages/register.vue';
import Home from './pages/home.vue';
import Profile from './pages/profile.vue';
import CreateProject from './pages/create-project.vue';
import EditProject from './pages/edit-project.vue';
import Project from './pages/project.vue';

import CreateStartUp from './pages/create-start-up.vue';
import EditStartUp from './pages/edit-start-up.vue';
import StartUp from './pages/startup.vue';

import Messages from './pages/messages.vue';
import Notifications from './pages/notifications.vue';

import Thread from './pages/thread.vue';
import StartupThread from './pages/startup-thread.vue';
import UserProfile from './pages/user-profile.vue';
import UserAvatar from './pages/user-avatar.vue';
import UserPassword from './pages/user-password.vue';
import UserCompany from './pages/user-company.vue';
import UserBank from './pages/user-bank.vue';
import UserProjects from './pages/user-projects.vue';
import UserProspected from './pages/user-prospected.vue';
import UserPage from './pages/user/index.vue';
import UserReferences from './pages/user/references.vue';
import UserFeedbacks from './pages/user/feedbacks.vue';
import UserProjectsPage from './pages/user/projects.vue';
import CreateFeedback from './pages/create-feedback.vue';
import CoFoundersProfile from './pages/co-founders-profile.vue';
import UserStartUps from './pages/user-startups.vue';
import UserStartUpProspected from './pages/user-startup-prospected.vue';
import MileStone from './components/project/milestone.vue';
import MilestoneMgmt from './components/project/milestone-management.vue';
import OwnerMilestoneMgmt from './components/project/owner/milestone-management.vue';
import ServiceDetail from './pages/service/detail.vue';
import OrderConfirmation from './pages/service/order-confirmation.vue';
import Instruction from './pages/service/instruction.vue';
import ThankYou from './pages/service/thankyou.vue';
import MyPackages from './pages/service/packages.vue';
import NewService from './pages/service/new-service.vue';
import MyOrderedPackages from './pages/service/ordered-packages.vue';
import MySoldPackages from './pages/service/sold-packages.vue';
import SoldPackageDetail from './pages/service/sold-package-detail.vue';
import OrderedPackageDetail from './pages/service/ordered-package-detail.vue';
import OrderedContact from './pages/service/ordered-contact.vue';
import CustomerSupport from './pages/customer-support.vue';
import Accompany from './pages/accompany/index.vue';
import CreateAccompany from './pages/accompany/create.vue';
import Dashboard from './pages/user/dashboard.vue';

export default [
    {
        path: '/',
        component: Home
    },
    {
        path: '/profile/:id',
        component: CoFoundersProfile
    },
    {
        path: '/user/profile',
        component: Profile,
        meta: {
            forAuth: true
        }
    },
    {
        path: '/login',
        component: Login,
        meta: {
            forGuests: true
        }
    },
    {
        path: '/register',
        component: Register,
        meta: {
            forGuests: true
        }
    },
    {
        path: '/projects/create',
        component: CreateProject,
        meta: {
            forAuth: true
        }
    },
    {
        path: '/projects/:id/edit',
        component: EditProject
    },
    {
        path: '/projects/:slug',
        component: Project
    },
    {
        path: '/projects/:slug/feedback',
        component: CreateFeedback
    },
    {
        path: '/projects/milestone/management/:id',
        component: MilestoneMgmt
    },
    {
        path: '/projects/milestone/owner/management/:id',
        component: OwnerMilestoneMgmt
    },
    {
        path: '/projects/milestone/:id',
        component: MileStone
    },
    {
    path: '/startups/create',
    component: CreateStartUp,
    meta: {
        forAuth: true
    }
    },
    {
        path: '/startups/:id/edit',
        component: EditStartUp
    },
    {
        path: '/startups/:slug',
        component: StartUp
    },
    {
        path: '/startups/:slug/feedback',
        component: CreateFeedback
    },
    {
        path: '/user/projects',
        component: UserProjects,
        meta: {
            forAuth: true
        }
    },
    {
        path: '/user/startups',
        component: UserStartUps,
        meta: {
            forAuth: true
        }
    },
    {
        path: '/user/prospected',
        component: UserProspected,
        meta: {
            forAuth: true
        }
    },
     {
        path: '/user/startup-prospected',
        component: UserStartUpProspected,
        meta: {
            forAuth: true
        }
    },
    {
        path: '/user/messages/thread/:id',
        component: Thread,
        meta: {
            forAuth: true
        }
    },
    {
        path: '/user/messages/startup-thread/:id',
        component: StartupThread,
        meta: {
            forAuth: true
        }
    },
    {
        path: '/user/profile',
        component: UserProfile,
        meta: {
            forAuth: true
        }
    },
    {
        path: '/user/avatar',
        component: UserAvatar,
        meta: {
            forAuth: true
        }
    },
    {
        path: '/user/password',
        component: UserPassword,
        meta: {
            forAuth: true
        }
    },
    {
        path: '/user/company',
        component: UserCompany,
        meta: {
            forAuth: true
        }
    },
    {
        path: '/user/bank',
        component: UserBank,
        meta: {
            forAuth: true
        }
    },
    {
        path: '/user/messages',
        component: Messages,
        meta: {
            forAuth: true
        }
    },
    {
        path: '/user/notifications',
        component: Notifications,
        meta: {
            forAuth: true
        }
    },
    {
        path: '/users/:id',
        component: UserPage,
        children: [
            {
                path: '',
                component: UserReferences
            },
            {
                path: 'feedbacks',
                component: UserFeedbacks
            },
            {
                path: 'projects',
                component: UserProjectsPage
            }
        ]
    },
    {
        path: '/service/detail/:id',
        component: ServiceDetail
    },
    {
        path: '/order/confirmation/:id',
        component: OrderConfirmation
    },
    {
        path: '/order/instruction/:id/:package_id',
        component: Instruction
    },
    {
        path: '/order/thankyou/:id/:ordered_package_id',
        component: ThankYou
    },
    {
        path: '/user/packages',
        component: MyPackages,
        meta: {
            forAuth: true
        }
    },
    {
        path: '/user/ordered-packages',
        component: MyOrderedPackages,
        meta: {
            forAuth: true
        }
    },
    {
        path: '/user/sold-packages',
        component: MySoldPackages,
        meta: {
            forAuth: true
        }
    },
    {
        path: '/user/sold-package/:id',
        component: SoldPackageDetail,
        meta: {
            forAuth: true
        }
    },
    {
        path: '/user/ordered-package/:id',
        component: OrderedPackageDetail,
        meta: {
            forAuth: true
        }
    },
    {
        path: '/user/ordered-contact/:id',
        component: OrderedContact,
        meta: {
            forAuth: true
        }
    },
    {
        path: '/service/create',
        component: NewService,
        meta: {
            forAuth: true
        }
    },
    {
        path: '/service/edit/:id',
        component: NewService,
        meta: {
            forAuth: true
        }
    },
    {
        path: '/customer-support/:id/:type',
        component: CustomerSupport,
        meta: {
            forAuth: true
        }
    },
    {
        path: '/accompany',
        component: Accompany,
        meta: {
            forAuth: true
        }
    },
    {
        path: '/accompany/create',
        component: CreateAccompany,
        meta: {
            forAuth: true
        }
    },
    {
        path: '/user/dashboard',
        component: Dashboard,
        meta: {
            forAuth: true
        }
    }
];