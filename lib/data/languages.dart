import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar_JOR': {
          'login': 'تسجيل الدخول',
          'create_new_account': 'انشاء حساب جديد',
          'forget_password': 'نسيت كلمة السر؟',
          'enter_your_password': 'ادخل رقمك السري',
          'enter_your_name': 'ادخل اسمك',
          'enter_your_email': 'ادخل بريدك الالكتروني',
          'dont_have_an_account': 'ليس لديك حساب؟',
          'start': 'إبدأ',
          'consult_only_with_a_doctor_you_trust': 'استشر فقط مع طبيب تثق به',
          'find_a_ot_of_specialist_doctor_in_one_place':
              'اعثر على العديد من الأطباء المتخصصين في مكان واحد',
          'get_connect_with_our_online_consultation':
              'اتصل بخدمات الاستشارة عبر الإنترنت لدينا',
          'thank_you': 'شكراً لك',
          'start_now': 'ابدأ الآن!',
          'where_everyone_is_here_to_help_you': 'حيث الجميع هنا لمساعدتك!',
          'lets_get_started': 'لنبدأ',
          'choose_user': 'اختر المستخدم',
          'doctor': 'طبيب',
          'patient': 'مريض',
          'sign_up': 'سجل',
          'you_must_enter_your_information_to_join':
              'يجب عليك إدخال معلوماتك للانضمام',
          'username': 'اسم المستخدم',
          'enter_your_username': 'أدخل اسم المستخدم',
          'please_enter_username_at_least_3_characters':
              'يرجى إدخال اسم مستخدم مكون من 3 أحرف على الأقل',
          'email': 'البريد الإلكتروني',
          'please_enter_a_valid_email': 'يرجى إدخال بريد إلكتروني صالح',
          'password': 'كلمة المرور',
          'enter_password': 'أدخل كلمة المرور',
          'confirm_password': 'تأكيد كلمة المرور',
          'confirm_your_password': 'أكد كلمة المرور',
          'password_must_not_be_at_least_8_charaters':
              'يجب ألا تكون كلمة المرور مكونة من 8 أحرف على الأقل',
          'already_have_an_acccount': 'هل لديك حساب بالفعل؟',
          'passwords_not_match': 'كلمات المرور غير متطابقة',
          'error_occured': 'حدث خطأ',
          'week_password': 'كلمة المرور ضعيفة',
          'email_already_in_use': 'البريد الإلكتروني مستخدم بالفعل',
          'please_try_again_later': 'يرجى المحاولة مرة أخرى لاحقاً',
          'remember_me': 'تذكرني',
          'submit': 'إرسال',
          'please_enter_your_email_to_reset_your_password':
              'يرجى إدخال بريدك الإلكتروني لإعادة تعيين كلمة المرور الخاصة بك',
          'back_to_login': 'العودة إلى تسجيل الدخول',
          'reset_password_link_sent_to_email':
              'تم إرسال رابط إعادة تعيين كلمة المرور إلى البريد الإلكتروني',
          'wrong_password': 'كلمة المرور خاطئة',
          'user_not_found': 'المستخدم غير موجود',
          'change_account_type': 'تغيير نوع الحساب',
          'welcome_back': 'مرحبًا بعودتك',
          'search_doctors_hospitals': 'البحث عن الأطباء والمستشفيات',
          'favourite_doctors': 'الأطباء المفضلون',
          'see_all': 'عرض الكل',
          'top_doctors': 'أفضل الأطباء',
          'call_ambulance': 'اتصل بالإسعاف',
          'surgery_package': 'حزمة الجراحة',
          'doctor_details': 'تفاصيل الطبيب',
          'about': 'حول',
          'appointment': 'موعد',
          'hospitals': 'المستشفيات',
          'book_private_consultation': 'حجز استشارة خاصة',
          'date': 'التاريخ',
          'reason': 'السبب',
          'change': 'تغيير',
          'describe_what_you_feel': 'وصف ما تشعر به',
          'payment_detail': 'تفاصيل الدفع',
          'payment_method': 'طريقة الدفع',
          'total': 'المجموع',
          'book': 'احجز',
          'consultation': 'استشارة',
          'admin_fee': 'رسوم إدارية',
          'my_profile': 'ملفي الشخصي',
          'edit_profile': 'تعديل الملف الشخصي',
          'privacy_policy': 'سياسة الخصوصية',
          'settings': 'الإعدادات',
          'help': 'مساعدة',
          'favorites': 'المفضلة',
          'logout': 'تسجيل الخروج',
          'delete_account': 'حذف الحساب',
          'password_manger': 'مدير كلمات المرور',
          'notifications': 'الإشعارات',
          'AI_assistant': 'المساعد الذكي',
          'typing': 'يكتب',
          'change_language': 'تغيير اللغة',
          'consultion_start': 'بداية الاستشارة',
          'you_can_consult_your_problem_to_the_doctor':
              'يمكنك استشارة الطبيب حول مشكلتك',
          'send': 'إرسال',
          'no_data': 'لا توجد بيانات',
          'private_conseltation': 'استشارة خاصة',
          'join_as_a_doctor': 'انضم كطبيب',
          'major': 'تخصص',
          'enter_your_major': 'أدخل تخصصك',
          'please_enter_your_major': 'يرجى إدخال تخصصك',
          'years_of_experence': 'سنوات الخبرة',
          'enter_years_of_experence': 'أدخل سنوات الخبرة',
          'please_enter_years_of_experence': 'يرجى إدخال سنوات الخبرة',
          "update": "تحديث",
          "date_of_birth": "تاريخ الميلاد",
          "phone_number": "رقم الهاتف",
          "enter_phone_number": "أدخل رقم الهاتف",
          'search_address': 'البحث عن العنوان',
          'sergery_pakage': 'حزمة الجراحة',
          'dr': 'دكتور',
          'home_screen': 'الشاشة الرئيسية',
          'scheduling': 'الجدولة',
          'you_are_out_of_consultation_time': 'لقد تجاوزت وقت الاستشارة',
          'sorry': 'عذراً',
          'add_new': 'إضافة جديد',
          'pick_date': 'اختر التاريخ',
          'pick_time': 'اختر الوقت',
          'enter_package_name': 'أدخل اسم الباقة',
          'package_name': 'اسم الباقة',
          'enter_package_price': 'أدخل سعر الباقة',
          'package_price': 'سعر الباقة',
          'package_pre': 'الباقة السابقة',
          'package_post': 'الباقة اللاحقة',
          'package_into': 'الباقة الداخلية',
          'supervised_by': 'بإشراف',
          'pick_hospital': 'اختر المستشفى',
          'review_the_consultation': 'راجع الاستشارة',
          'review': 'مراجعة',
          'my_packages': 'باقاتي',
          'set_price': 'تحديد السعر',
          'price': 'السعر',
          'error': 'خطأ',
          'please_select_hospital': 'الرجاء اختيار المستشفى',
          'scheduled_appointment': 'موعد محدد',
          'reminder_tommorow': 'تذكير غداً',
          'change_appointment': 'تم تغيير الموعد',
          'years': 'سنوات',
          'months': 'أشهر',
          's': 'ثواني',
          'm': 'دقائق',
          'h': 'ساعات',
          'w': 'أسابيع',
          'd': 'أيام',
          "ok": "تم",
          "success": "تم بنجاح",
        },
        'en_US': {
          'login': 'Login',
          'create_new_account': 'Create new account',
          'forget_password': 'Forget password?',
          'enter_your_password': 'Enter your password',
          'enter_your_name': 'Enter your name',
          'enter_your_email': 'Enter your email',
          'dont_have_an_account': 'Don\'t have an account?',
          'start': 'Start',
          'consult_only_with_a_doctor_you_trust':
              'Consult only with a doctor you trust',
          'find_a_ot_of_specialist_doctor_in_one_place':
              'Find a ot of specialist doctor in one place',
          'get_connect_with_our_online_consultation':
              'Get connect with our online consultation',
          'thank_you': 'Thank you',
          'start_now': 'Start now!',
          'where_everyone_is_here_to_help_you':
              'Where everyone is here to help you!',
          'lets_get_started': 'Lets get started',
          'choose_user': 'Choose User',
          'doctor': 'Doctor',
          'patient': 'Patient',
          'sign_up': 'Sign up',
          'you_must_enter_your_information_to_join':
              'You must enter your information to join',
          'username': 'Username',
          'enter_your_username': 'Enter your username',
          'please_enter_username_at_least_3_characters':
              'Please enter username at least 3 characters',
          'email': 'Email',
          'name': 'Name',
          'please_enter_your_name': 'Please enter your name',
          'please_enter_a_valid_email': 'Please enter a valid email',
          'password': 'Password',
          'enter_password': 'Enter password',
          'confirm_password': 'Confirm password',
          'confirm_your_password': 'Confirm your password',
          'password_must_not_be_at_least_8_charaters':
              'Password must not be at least 8 charaters',
          'already_have_an_acccount': 'Already have an acccount ?',
          'passwords_not_match': 'Passwords not match',
          'error_occured': 'Error occured',
          'week_password': 'Week password',
          'email_already_in_use': 'Email already in use',
          'please_try_again_later': 'Please try again later',
          'remember_me': 'Remember me',
          'submit': 'Submit',
          'please_enter_your_email_to_reset_your_password':
              'Please enter your email to reset your password',
          'back_to_login': 'Back to Login',
          'reset_password_link_sent_to_email':
              'Reset password link sent to email',
          'wrong_password': 'Wrong password',
          'user_not_found': 'User not found',
          'change_account_type': 'Change account type',
          'welcome_back': 'Welcome back',
          'search_doctors_hospitals': 'Search doctors, hospitals',
          'favourite_doctors': 'Favourite Doctors',
          'see_all': 'See all',
          'top_doctors': 'Top doctors',
          'call_ambulance': 'Call ambulance',
          'surgery_package': 'Surgery package',
          'doctor_details': 'Doctor Details',
          'about': 'About',
          'appointment': 'Appointment',
          'hospitals': 'Hospitals',
          'book_private_consultation': 'Book Private Consultation',
          'date': 'Date',
          'reason': 'Reason',
          'change': 'Change',
          'describe_what_you_feel': 'Describe what you feel',
          'payment_detail': 'Payment Detail',
          'payment_method': 'Payment Method',
          'total': 'Total',
          'book': 'Book',
          'consultation': 'Consultation',
          'admin_fee': 'Admin Fee',
          'my_profile': 'My Profile',
          'edit_profile': 'Edit profile',
          'privacy_policy': 'Privacy Policy',
          'settings': 'Settings',
          'help': 'Help',
          'favorites': 'Favorites',
          'logout': 'Logout',
          'delete_account': 'Delete account',
          'password_manger': 'Password manger',
          'notifications': 'Notifications',
          'AI_assistant': 'AI assistant',
          'typing': 'typing',
          'describe': 'Describe',
          'done': 'Done',
          'jod': 'JOD',
          'visa': 'VISA',
          'cash': 'Cash',
          'pay': 'Pay',
          'number': 'Card Number',
          'card_holder': 'Card Holder',
          'expired_date': 'Expired date',
          'add_new_card': 'Add new card',
          'type_message': 'Type message...',
          'change_language': 'Change language',
          'consultion_start': 'Consultion start',
          'you_can_consult_your_problem_to_the_doctor':
              'You can consult your problem to the doctor',
          'send': 'Send',
          'no_data': 'No data',
          'private_conseltation': 'Private conseltation',
          'join_as_a_doctor': 'Join as a doctor',
          'major': 'Major',
          'enter_your_major': 'Enter your major',
          'please_enter_your_major': 'Please enter your major',
          'years_of_experence': 'Years of experence',
          'enter_years_of_experence': 'Enter years of experence',
          'please_enter_years_of_experence': 'Please nter years of experence',
          'update': 'Update',
          'date_of_birth': 'Date of birth',
          'phone_number': 'Phone number',
          'enter_phone_number': 'Enter phone number',
          'search_address': 'Search address',
          'sergery_package': 'Sergery Package',
          'dr': 'Dr',
          'home_screen': 'Home screen',
          'scheduling': 'Scheduling',
          'you_are_out_of_consultation_time':
              'You are out of consultation time',
          'sorry': 'Sorry',
          'add_new': 'Add new',
          'pick_date': 'Pick date',
          'pick_time': 'Pick time',
          'enter_package_name': 'Enter package name',
          'package_name': 'Package name',
          'enter_package_price': 'Enter package price',
          'package_price': 'Package price',
          'package_pre': 'Package pre',
          'package_post': 'Package post',
          'package_into': 'Package into',
          'supervised_by': 'Supervised by',
          'pick_hospital': 'Pick hospital',
          'review_the_consultation': 'Review the consultation',
          'review': 'Review',
          'my_packages': 'My packages',
          'set_price': 'Set price',
          'price': 'Price',
          'error': 'Error',
          'please_select_hospital': 'Please select hospital',
          'scheduled_appointment': 'Scheduled appointment',
          'reminder_tommorow': 'Reminder tommorow',
          'change_appointment': 'Scheduled changed',
          "years": "Years",
          "months": "Months",
          "s": "s",
          "m": "m",
          "h": "h",
          "w": "w",
          "d": "d",
          "ok": "OK",
          "success": "Success",
        },
      };
}
