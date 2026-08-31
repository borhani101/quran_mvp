# Quran MVP - Project Documentation

**نسخه:** 0.1.0  
**وضعیت:** MVP (حداقل محصول قابل اجرا)  
**زبان:** Dart/Flutter  
**معماری:** Clean Architecture + Provider Pattern (برای آینده)

---

## 📋 فهرست مطالب

1. [Architecture & State Management](#architecture)
2. [Design System & Theme](#design-system)
3. [Data Model](#data-model)
4. [Component Hierarchy](#components)
5. [Directory Structure](#directory-structure)
6. [Next Steps / Roadmap](#roadmap)

---

## <a name="architecture"></a>🏗️ Architecture & State Management

### معماری فعلی:
- **Clean Architecture** (سطح پایه)
- **Stateful Widgets** برای UI logic
- **Singleton Pattern** برای `QuranService`
- **FutureBuilder** برای async operations

### مدیریت State:
- **StatefulWidget** برای صفحات
- **Provider** (برای آینده: bookmark، تنظیمات کاربر)

### طبقات:
```
lib/
├── models/          → Data models
├── services/        → Business logic
├── screens/         → UI Screens
├── widgets/         → Reusable components
└── theme/           → Design tokens
```

---

## <a name="design-system"></a>🎨 Design Tokens & Theme System

### رنگ‌های اصلی (Primary Colors):
| نام | کد Hex | توصیف |
|-----|--------|-------|
| Primary Dark | `#1F4E3D` | سبز یشمی تیره (رنگ اصلی) |
| Primary Medium | `#2A6B57` | سبز متوسط |
| Primary Light | `#3D8B71` | سبز روشن |

### رنگ‌های پس‌زمینه:
| نام | کد Hex | توصیف |
|-----|--------|-------|
| Bg Cream | `#FBF8F0` | کرم ملایم (شبیه کاغذ قرآنی) |
| Bg Light | `#FFFAF5` | سفید ملایم |
| Bg Grey | `#F5F3EF` | خاکستری روشن |

### رنگ‌های تاکیدی (Accent):
| نام | کد Hex | توصیف |
|-----|--------|-------|
| Gold Accent | `#D4AF7C` | طلایی ملایم |
| Gold Dark | `#C19A4A` | طلایی تیره |

### Typography:
```dart
// فونت‌های Text Theme از Material Design 3
displayLarge      → 32px, Bold
headlineSmall     → 24px, Semi-bold
titleMedium       → 16px, Medium
bodyMedium        → 14px, Regular
bodySmall         → 12px, Regular
```

### Spacing:
```dart
const EdgeInsets.symmetric(horizontal: 16, vertical: 12)  // Standard padding
const SizedBox(height: 8)  // Standard gap
BorderRadius.circular(12)  // Standard border radius
```

### Shadows:
```dart
// Light shadow برای کارت‌ها
blurRadius: 8, offset: (0, 2)

// Medium shadow برای dialogs
blurRadius: 12, offset: (0, 4)
```

---

## <a name="data-model"></a>📊 Data Model

### Surah Model
```dart
class Surah {
  final int number;           // ترتیب سوره (1-114)
  final String name;          // نام عربی
  final String nameAr;        // نام عربی (اختیاری)
  final String? nameFa;       // نام فارسی (اختیاری)
  final List<Ayah> ayahs;     // لیست آیات
  final String type;          // 'مکی' یا 'مدنی'
  final int verseCount;       // تعداد آیات
  final int? juz;             // شماره جزء (اختیاری)
  final int? page;            // شماره صفحه (اختیاری)
}
```

### Ayah Model
```dart
class Ayah {
  final int number;       // شماره آیه در سوره
  final String textAr;    // متن عربی
  final String textFa;    // ترجمه فارسی
}
```

### JSON Format (assets/data/quran.json):
```json
{
  "surahs": [
    {
      "number": 1,
      "name": "الفاتحه",
      "type": "مکی",
      "verseCount": 7,
      "ayahs": [
        {
          "number": 1,
          "text_ar": "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ",
          "text_fa": "به نام خداوند بخشنده مهربان"
        }
      ]
    }
  ]
}
```

---

## <a name="components"></a>🧩 Component Hierarchy

### صفحات (Screens):
1. **HomeScreen** - صفحه اصلی با دو tab
2. **SurahListScreen** - لیست سوره‌ها
3. **SearchScreen** - صفحه جستجو
4. **SurahDetailScreen** - صفحه جزئیات سوره

### ویجت‌های سفارشی (Custom Widgets):
1. **SurahCard** ✅
   - نمایش سوره در فرمت کارت
   - شماره در دایره طلایی
   - نام و اطلاعات (مکی/مدنی)
   
2. **SearchBarWidget** ✅
   - نوار جستجو RTL
   - آیکن‌های پویا

3. **AyahTile** ✅
   - نمایش هر آیه
   - متن عربی و فارسی

### خدمات (Services):
1. **QuranService** - Singleton
   - `loadSurahs()` - بارگذاری داده‌ها
   - `getSurahs()` - دریافت سوره‌ها
   - `search()` - جستجو

---

## <a name="directory-structure"></a>📁 Directory Structure

```
lib/
├── main.dart                      # نقطه ورود برنامه
├── models/
│   ├── surah.dart                # مدل سوره
│   └── ayah.dart                 # مدل آیه
├── services/
│   └── quran_service.dart        # سرویس قرآن
├── screens/
│   ├── home_screen.dart          # صفحه اصلی
│   ├── surah_list_screen.dart    # لیست سوره‌ها
│   ├── search_screen.dart        # صفحه جستجو
│   └── surah_detail_screen.dart  # جزئیات سوره
├── widgets/
│   ├── surah_card.dart           # کارت سوره
│   ├── search_bar_widget.dart    # نوار جستجو
│   └── ayah_tile.dart            # کاشی آیه
└── theme/
    ├── app_colors.dart           # رنگ‌های اپ
    └── app_theme.dart            # تم Material

assets/
└── data/
    └── quran.json                # داده‌های قرآن
```

---

## <a name="roadmap"></a>🚀 Next Steps / Roadmap

### Phase 1 (جاری):
- ✅ Setup قاعده‌ای Flutter
- ✅ Theme & Design System
- ✅ Data Models
- ✅ UI Components (SurahCard, SearchBar)
- ⏳ **TODO:** تکمیل صفحه SearchScreen و هماهنگی با SurahCard

### Phase 2 (بعدی):
- [ ] **Bookmarks Feature**
  - ذخیره نشان‌های کاربر
  - صفحه نشان‌ها (Bookmarks Tab)
  - پیاده‌سازی SharedPreferences یا SQLite

- [ ] **Audio Support**
  - پخش صوت آیات
  - کنترل پخش (play, pause, seek)
  - تنظیمات صوتی

- [ ] **State Management Upgrade**
  - مایگریشن به Provider یا Riverpod
  - Global state برای bookmarks و تنظیمات

- [ ] **Search Enhancement**
  - Debouncing برای جستجو
  - فیلترینگ بر اساس سوره
  - Tagging و categorization

- [ ] **User Settings**
  - انتخاب اندازه فونت
  - تم روز/شب (Dark Mode)
  - انتخاب ترجمه

### Phase 3 (طولانی‌مدت):
- [ ] Offline Sync
- [ ] Multi-language Support
- [ ] Tajweed Rules
- [ ] Qiblah Direction
- [ ] Prayer Times Integration

---

## 🛠️ استفاده از Theme

### در تمام Widgets:
```dart
// رنگ‌ها
AppColors.primaryDark
AppColors.bgCream
AppColors.goldAccent

// استایل‌ها
Theme.of(context).textTheme.titleMedium
AppTheme.lightTheme

// Shadows
AppShadows.cardShadows
```

---

## 📦 Dependencies

```yaml
flutter: ">=3.0.0"
cupertino_icons: ^1.0.2
```

**بعدی قرار است:**
- provider: ^6.x
- shared_preferences: ^2.x
- just_audio: ^0.9.x

---

## 🎯 نکات اهم

1. **RTL Support**: تمام متن‌ها و layout به صورت RTL طراحی شده‌اند
2. **Performance**: Singleton pattern برای QuranService
3. **Modularity**: تقسیم‌بندی واضح بین layers
4. **Scalability**: ساختار آماده برای اضافه‌کردن features جدید

---

**آخرین بروزرسانی:** 31 آگوست 2026  
**متعهد:** Copilot  
**پروژه:** Quran MVP
