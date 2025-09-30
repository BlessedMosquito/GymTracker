# Instrukcja uruchomienia aplikacji na iPhone

## Wymagania
- macOS  
- Zainstalowany [Flutter SDK](https://docs.flutter.dev/get-started/install/macos)  
- Zainstalowany **Xcode** (z App Store)  
- (opcjonalnie) Visual Studio Code jako edytor  

## Kroki

1. Pobierz projekt z GitHuba:
   ```bash
   git clone https://github.com/TWOJE_REPOZYTORIUM.git
   cd TWOJE_REPOZYTORIUM
2. Zainstaluj zależności:
flutter pub get
3. Uruchom symulator iPhone:
open -a Simulator
4. Uruchom aplikację:
flutter run

# CreateSchedulePage.dart

Ten plik odpowiada za tworzenie planu treningowego w aplikacji.  
Użytkownik może wybierać dni tygodnia, a następnie przypisywać do nich ćwiczenia wraz z liczbą serii (*sets*) i powtórzeń (*reps*).

## Funkcjonalności

- **Lista dni tygodnia**  
  Każdy dzień jest reprezentowany przyciskiem. Po kliknięciu otwiera się okno dialogowe dla tego dnia.

- **Dodawanie ćwiczeń**  
  - Po kliknięciu przycisku **Add Exercise** otwiera się formularz.  
  - Użytkownik podaje nazwę ćwiczenia, liczbę serii i powtórzeń (wybierane za pomocą `CupertinoPicker`).  
  - Jeśli dane są niepoprawne (np. brak nazwy ćwiczenia), pojawia się komunikat o błędzie.

- **Podgląd ćwiczeń dla dnia**  
  - W oknie dialogowym widoczna jest lista wszystkich dodanych ćwiczeń w formie `nazwa ćwiczenia – liczba serii x liczba powtórzeń`.

- **Zapisywanie treningu**  
  - Użytkownik może zapisać cały trening klikając **Save Training**.  
  - Trening trafia do listy `trainings`.  
  - Jeśli żaden dzień nie zawiera ćwiczeń, pojawia się komunikat (`SnackBar`).

## Struktura pliku

- `CreateSchedulePage` – główny widżet strony.  
- `daysOfWeek` – lista dni tygodnia.  
- `schedule` – mapa przechowująca dni tygodnia i przypisane do nich ćwiczenia.  
- `_openExerciseFormDialog` – otwiera formularz dodawania ćwiczenia.  
- `_openDayDialog` – otwiera okno dialogowe z listą ćwiczeń dla wybranego dnia.  
- `_saveTraining` – zapisuje cały trening do globalnej listy `trainings`.  

## UI (interfejs użytkownika)

- Cała strona wykorzystuje **GradientScaffold** z zielonym gradientem (`LinearGradient`).  
- Przyciski (dni tygodnia, dodawanie ćwiczeń, zapisywanie planu) mają:
  - tło z gradientem,
  - czarny tekst,
  - zaokrąglone rogi.  

## Podsumowanie

Plik **CreateSchedulePage.dart** umożliwia tworzenie i zarządzanie planem treningowym.  
Dzięki formularzom i pickerom użytkownik może w prosty sposób zdefiniować ćwiczenia, a następnie zapisać je jako kompletny trening.



# MyTrainingsPage.dart

Ten plik odpowiada za wyświetlanie listy zapisanych treningów.  
Użytkownik może zobaczyć wszystkie utworzone wcześniej plany treningowe i przejść do szczegółów wybranego treningu.

## Funkcjonalności

- **Brak treningów**  
  - Jeśli lista `trainings` jest pusta, wyświetlany jest komunikat:  
    *"No trainings yet"* (z białym tekstem na środku ekranu).

- **Lista treningów**  
  - Jeśli w liście `trainings` znajdują się zapisane plany:  
    - Każdy trening jest wyświetlany w postaci **kontenera z gradientowym tłem**.  
    - Widoczna jest nazwa treningu (`training.name`).  
    - Kliknięcie w trening otwiera stronę **TrainingDetailPage** z jego szczegółami.

## Struktura pliku

- `MyTrainingsPage` – stateless widget odpowiedzialny za całą stronę.  
- `trainings` – globalna lista treningów importowana z `data.dart`.  
- `GradientScaffold` – używany jako główny kontener z gradientowym tłem.  
- `GradientAppBar` – nagłówek z zielonym gradientem.  
- `ListView.builder` – dynamiczne generowanie listy treningów.  
- `ListTile` – pojedynczy element listy reprezentujący trening.

## UI (interfejs użytkownika)

- **GradientAppBar** z napisem *"My Trainings"*.  
- **Gradientowe karty treningów** (`LinearGradient` w odcieniach zieleni).  
- Nazwy treningów są wyświetlane czarnym tekstem.  
- Zaokrąglone rogi kart (`BorderRadius.circular(12)`).  
- Kliknięcie w element listy przenosi do **TrainingDetailPage**.

## Podsumowanie

Plik **MyTrainingsPage.dart** obsługuje ekran, na którym użytkownik przegląda swoje zapisane treningi.  
Dzięki gradientowemu UI całość jest spójna z resztą aplikacji, a kliknięcie w trening umożliwia szybki dostęp do jego szczegółów.

# TrainingDetailPage.dart

Ten plik odpowiada za wyświetlanie szczegółów wybranego treningu.  
Użytkownik może przeglądać ćwiczenia przypisane do poszczególnych dni, a także edytować lub usuwać poszczególne elementy.

## Funkcjonalności

- **Wyświetlanie planu treningowego**  
  - Ćwiczenia są pogrupowane według dni tygodnia i wyświetlane w rozwijanych sekcjach (`ExpansionTile`).  
  - Każdy dzień pokazuje listę ćwiczeń z nazwą, liczbą serii (`sets`) i powtórzeń (`reps`).

- **Edycja ćwiczeń**  
  - Kliknięcie ikony ✏️ (`Icons.edit`) otwiera okno dialogowe.  
  - Użytkownik może zmienić nazwę, liczbę serii i powtórzeń.  
  - Zmiany są zapisywane po naciśnięciu przycisku **Save**.

- **Usuwanie ćwiczeń**  
  - Kliknięcie ikony 🗑️ (`Icons.delete`) usuwa ćwiczenie z listy dla danego dnia.

## Struktura pliku

- `TrainingDetailPage` – **StatefulWidget**, który przyjmuje obiekt `Training` (przekazywany ze strony listy treningów).  
- `_editExercise` – metoda otwierająca formularz edycji ćwiczenia.  
- `_deleteExercise` – metoda usuwająca wybrane ćwiczenie z listy.  
- `ExpansionTile` – rozwijane sekcje grupujące ćwiczenia według dni tygodnia.  
- `ListTile` – pojedynczy element listy reprezentujący jedno ćwiczenie.

## UI (interfejs użytkownika)

- **GradientAppBar** z nazwą wybranego treningu.  
- **ExpansionTile** – każda sekcja to dzień tygodnia.  
- **ListTile** – prezentuje pojedyncze ćwiczenie w karcie z gradientowym tłem:  
  - **Nazwa ćwiczenia** – czarny tekst.  
  - **Opis** – liczba serii i powtórzeń.  
  - **Przyciski akcji** – edycja (niebieska ikona) i usuwanie (czerwona ikona).  
- Gradientowe karty (`LinearGradient` w odcieniach zieleni) z zaokrąglonymi rogami.

## Podsumowanie

Plik **TrainingDetailPage.dart** obsługuje ekran szczegółów treningu.  
Dzięki niemu użytkownik może:
- łatwo przejrzeć swój plan,
- edytować błędnie wprowadzone dane,
- usuwać zbędne ćwiczenia.  

Całość jest spójna z gradientowym motywem aplikacji.

