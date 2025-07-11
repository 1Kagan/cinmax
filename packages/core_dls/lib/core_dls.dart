/// core_dls library provides atomic reusable widgets
/// to be used within the super app
library core_dls;

// 3rd party
export 'package:intl/intl.dart';
export 'package:fluttertoast/fluttertoast.dart';

// Animations
export 'src/animations/fade_animation.dart';

// Appbars
export 'src/components/app_bar/bottom_sheet_appbar.dart';
export 'src/components/app_bar/mainnode_appbar.dart';
export 'src/components/app_bar/navigation_appbar.dart';
export 'src/components/app_bar/subpage_appbar.dart';

// Appointments Past Card
export 'src/components/appointment/appointments_past_card/appointments_past_card.dart';

// Appointments Upcoming Card
export 'src/components/appointment/appointments_upcoming_card/appointments_upcoming_card.dart';

// Direction Button
export 'src/components/appointment/button/small_button.dart';

// Location
export 'src/components/appointment/location/location_card.dart';
export 'src/components/appointment/location/location_list_tile.dart';

// Appointment
// Pop-up
export 'src/components/appointment/pop_up/pop_up.dart';
export 'src/components/appointment/showroom_list_tile/model/radio_widgets_parameters.dart';

// Showroom List Tile
export 'src/components/appointment/showroom_list_tile/showroom_list_tile.dart';

// Avatars
export 'src/components/avatars/avatar.dart';

// Bubble
export 'src/components/bubble/navigation_speech_bubble.dart';

// Buttons
export 'src/components/button/app_back_button.dart';
export 'src/components/button/app_skip_button.dart';
export 'src/components/button/detail_button.dart';
export 'src/components/button/primary_button.dart';
export 'src/components/button/secondary_button.dart';
export 'src/components/button/underlined_text_button.dart';
export 'src/components/button/custom_action_button.dart';

// Badge Tile
export 'src/components/cards/badge_tile/badge_tile.dart';

// Card
export 'src/components/cards/onboarding_card.dart';

// Profile
export 'src/components/cards/profile/profile.dart';

// Checkbox
export 'src/components/checkbox/app_checkbox.dart';

// Dropdown
export 'src/components/drop_down/app_drop_down.dart';
export 'src/components/drop_down/app_reactive_drop_down.dart';
export 'src/components/drop_down/drop_down_model.dart';

// Bottom sheet
export 'src/components/feedbacks/bottom_sheet/app_bottom_sheet.dart';
export 'src/components/feedbacks/bottom_sheet/widgets/close_icon.dart';

// Indicators
export 'src/components/indicator/dot_indicator.dart';
export 'src/components/indicator/loading_indicator.dart';

// Layouts
export 'src/components/layout/bottom_sheet/bottom_sheet_layout.dart';
export 'src/components/layout/bottom_sheet/error_bottom_sheet_layout.dart';
export 'src/components/layout/bottom_sheet/success_bottom_sheet_layout.dart';
export 'src/components/layout/mainnode_layout.dart';
export 'src/components/layout/subpage_layout.dart';

// Lists
export 'src/components/lists/accordion_list_tile.dart';
export 'src/components/lists/app_list_tile.dart';
export 'src/components/lists/checkbox_list_tile.dart';
export 'src/components/lists/checkbox_list_tile_with_link.dart';
export 'src/components/lists/form_radio_list_tile.dart';
export 'src/components/lists/form_switch_list_tile.dart';
export 'src/components/lists/link_list_tile.dart';

// Misc
export 'src/components/misc/absorb_pointer_and_opacity.dart';
export 'src/components/misc/chips/chips.dart';
export 'src/components/misc/informative_text.dart';
export 'src/components/misc/list_tile_divider.dart';
export 'src/components/misc/loader.dart';
export 'src/components/misc/profile_photo.dart';

// Radio Button
export 'src/components/radio_button/app_radio_button.dart';

// Slider
export 'src/components/slider/app_slider.dart';
export 'src/components/slider/model/slider_color_theme.dart';
export 'src/components/tabbar/app_tab.dart';

// TabBar
export 'src/components/tabbar/app_tab_bar_view.dart';
export 'src/components/tabbar/app_configurable_tab_view.dart';
export 'src/components/tabbar/app_scrollable_tab_bar_view.dart';

// Text Box
export 'src/components/text_box/text_box.dart';
export 'src/components/text_box/title_text_box.dart';
export 'src/components/text_field/app_content_text_box_field.dart';
export 'src/components/text_field/app_date_picker_text_field.dart';
export 'src/components/text_field/app_reactive_content_text_box_field.dart';
export 'src/components/text_field/app_reactive_date_text_field.dart';
export 'src/components/text_field/app_reactive_password_text_field.dart';
export 'src/components/text_field/app_reactive_phone_field.dart';
export 'src/components/text_field/app_reactive_text_field.dart';
export 'src/components/text_field/app_search_text_field.dart';

// Text Field
export 'src/components/text_field/app_text_field.dart';
export 'src/components/text_field/navigation_search_text_field.dart';
export 'src/constants/assets.gen.dart' hide SvgGenImage;

// Constants
export 'src/constants/constants.dart';

// Extensions
export 'src/extensions/app_animation_extension.dart';
export 'src/extensions/app_bottom_sheet_extension.dart';
export 'src/extensions/toast_extension.dart';
export 'src/extensions/widget_extension.dart';

// Localization
export 'src/localization/localization_delegate.dart';

// Theme
export 'src/theme/app_color_theme.dart';
export 'src/theme/app_text_theme.dart';

// Utils
export 'src/utils/text_input_formatters/text_input_formatters.dart';
