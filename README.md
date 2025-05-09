# wpx_atmrobbery - Advanced ATM Robbery Script

An advanced ATM robbery script for FiveM servers, primarily designed for QBCore but adaptable for other frameworks. This script allows players to rob ATMs using a minigame, with configurable rewards, cooldowns, and police alerts.

---

## English

### Preview

[![Watch the video](https://via.placeholder.com/1280x720.png?text=Click+to+Watch+Preview+Video)](https://www.youtube.com/watch?v=YOUR_PREVIEW_VIDEO_ID_HERE)

*(Replace the placeholder image and link above with your actual preview video.)*

### Features

*   Target-based ATM interaction.
*   Minigame to complete the robbery (configurable, default uses `ps-ui` Scrambler).
*   Configurable required item to start the robbery.
*   Randomized rewards.
*   Configurable cooldowns for ATMs and players.
*   Option to remove ATM cooldown on failed attempts.
*   Police alert system with configurable chance and event.
*   Minimum police online requirement (configurable).
*   Localization support (English and Turkish included by default).
*   Detailed configuration file (`config.lua`) with comments.

### Dependencies

*   **Framework:**
    *   `qb-core` (Primarily designed for, can be adapted)
*   **Targeting:**
    *   `ox_target` (Recommended) or `qb-target`
*   **Inventory:**
    *   `ox_inventory` (Recommended) or `qb-inventory`
*   **UI & Minigames:**
    *   `ps-ui` (Used for the default Scrambler minigame)
    *   `ox_lib` (Used for notifications and other utilities)
*   **Database (Optional, if you plan to use features requiring it, though not explicitly used by base script logic currently):**
    *   `oxmysql` (Included in server_scripts, good for future expansions)

### Installation

1.  **Download the Script:**
    *   Download the latest version of `wpx_atmrobbery` from this repository.
2.  **Place in Resources:**
    *   Extract the downloaded archive and place the `wpx_atmrobbery` folder into your server's `resources` directory.
3.  **Configure `config.lua`:**
    *   Open `wpx_atmrobbery/config.lua`.
    *   Adjust settings like `Config.Framework`, `Config.InventoryType`, `Config.TargetType` if auto-detection is not working or if you prefer manual setup.
    *   Customize `Config.RequiredItem`, rewards, cooldowns, and especially `Config.PoliceAlertEvent` to match your server's police alert system. Detailed comments in the file will guide you.
    *   Ensure `Config.Language` is set to your preferred language (`en` or `tr`, or add your own locale files).
4.  **Ensure Dependencies:**
    *   Make sure all the scripts listed under "Dependencies" are installed and started on your server.
5.  **Add to Server Configuration:**
    *   Add `ensure wpx_atmrobbery` to your `server.cfg` or `resources.cfg`, ensuring it's started *after* its dependencies (e.g., after `qb-core`, `ox_lib`, `ps-ui`, your target and inventory scripts).

    ```cfg
    # Example load order
    ensure ox_lib
    ensure oxmysql # If used
    ensure qb-core
    ensure ox_inventory # or qb-inventory
    ensure ox_target   # or qb-target
    ensure ps-ui
    ensure wpx_atmrobbery
    ```

6.  **Restart Server:**
    *   Restart your FiveM server or the resource if your server allows live resource starting.

### Usage

*   Players need the item specified in `Config.RequiredItem` (e.g., "advanced_circuit") in their inventory.
*   Approach an ATM prop (models defined in `Config.ATMProps`).
*   Use your target system (e.g., `ox_target` or `qb-target`) to interact with the ATM.
*   An option to "Rob ATM" (or your localized text) should appear.
*   Upon selecting, the minigame will start (if all conditions like minimum police and cooldowns are met).
*   Successfully completing the minigame will grant a random reward. Failure will consume the item and may trigger a shorter ATM cooldown (or none, depending on `Config.RemoveCooldownOnFail`).

---

## Türkçe

### Önizleme

[![Videoyu İzle](https://via.placeholder.com/1280x720.png?text=Önizleme+Videosunu+İzlemek+İçin+Tıkla)](https://www.youtube.com/watch?v=YOUR_PREVIEW_VIDEO_ID_HERE)

*(Yukarıdaki yer tutucu görseli ve bağlantıyı kendi önizleme videonuzla değiştirin.)*

### Özellikler

*   Hedefleme sistemi tabanlı ATM etkileşimi.
*   Soygunu tamamlamak için mini oyun (yapılandırılabilir, varsayılan olarak `ps-ui` Scrambler kullanır).
*   Soygunu başlatmak için gerekli eşya yapılandırılabilir.
*   Rastgele ödüller.
*   ATM'ler ve oyuncular için yapılandırılabilir bekleme süreleri.
*   Başarısız denemelerde ATM bekleme süresini kaldırma seçeneği.
*   Yapılandırılabilir şans ve olay ile polis uyarı sistemi.
*   Minimum aktif polis sayısı gereksinimi (yapılandırılabilir).
*   Yerelleştirme desteği (İngilizce ve Türkçe varsayılan olarak dahildir).
*   Yorumlarla detaylandırılmış yapılandırma dosyası (`config.lua`).

### Gereksinimler

*   **Framework:**
    *   `qb-core` (Öncelikli olarak bunun için tasarlandı, uyarlanabilir)
*   **Hedefleme Sistemi:**
    *   `ox_target` (Önerilir) veya `qb-target`
*   **Envanter Sistemi:**
    *   `ox_inventory` (Önerilir) veya `qb-inventory`
*   **Arayüz & Mini Oyunlar:**
    *   `ps-ui` (Varsayılan Scrambler mini oyunu için kullanılır)
    *   `ox_lib` (Bildirimler ve diğer yardımcı işlevler için kullanılır)
*   **Veritabanı (İsteğe Bağlı, eğer gerektiren özellikler kullanmayı planlıyorsanız, ancak şu an temel script mantığı tarafından açıkça kullanılmıyor):**
    *   `oxmysql` (server_scripts içinde dahil edilmiştir, gelecekteki genişletmeler için iyidir)

### Kurulum

1.  **Script'i İndirin:**
    *   Bu depodan `wpx_atmrobbery`'nin en son sürümünü indirin.
2.  **Resources Klasörüne Atın:**
    *   İndirilen arşivi çıkarın ve `wpx_atmrobbery` klasörünü sunucunuzun `resources` dizinine yerleştirin.
3.  **`config.lua` Dosyasını Yapılandırın:**
    *   `wpx_atmrobbery/config.lua` dosyasını açın.
    *   Otomatik algılama çalışmıyorsa veya manuel kurulumu tercih ediyorsanız `Config.Framework`, `Config.InventoryType`, `Config.TargetType` gibi ayarları düzenleyin.
    *   `Config.RequiredItem`, ödüller, bekleme süreleri ve özellikle `Config.PoliceAlertEvent` ayarını sunucunuzun polis uyarı sistemine uyacak şekilde özelleştirin. Dosyadaki ayrıntılı yorumlar size yol gösterecektir.
    *   `Config.Language` ayarının tercih ettiğiniz dile (`en` veya `tr`) ayarlandığından emin olun veya kendi yerelleştirme dosyalarınızı ekleyin.
4.  **Gereksinimleri Sağlayın:**
    *   "Gereksinimler" başlığı altında listelenen tüm script'lerin sunucunuzda kurulu ve başlatılmış olduğundan emin olun.
5.  **Sunucu Yapılandırmasına Ekleyin:**
    *   `ensure wpx_atmrobbery` satırını `server.cfg` veya `resources.cfg` dosyanıza ekleyin. Bağımlılıklarından *sonra* başlatıldığından emin olun (örneğin, `qb-core`, `ox_lib`, `ps-ui`, hedefleme ve envanter script'lerinizden sonra).

    ```cfg
    # Örnek yükleme sırası
    ensure ox_lib
    ensure oxmysql # Kullanılıyorsa
    ensure qb-core
    ensure ox_inventory # ya da qb-inventory
    ensure ox_target   # ya da qb-target
    ensure ps-ui
    ensure wpx_atmrobbery
    ```

6.  **Sunucuyu Yeniden Başlatın:**
    *   FiveM sunucunuzu veya sunucunuz canlı kaynak başlatmaya izin veriyorsa kaynağı yeniden başlatın.

### Kullanım

*   Oyuncuların envanterlerinde `Config.RequiredItem` içinde belirtilen eşyaya (örneğin, "advanced_circuit") sahip olmaları gerekir.
*   Bir ATM prop'una (modeller `Config.ATMProps` içinde tanımlıdır) yaklaşın.
*   ATM ile etkileşim kurmak için hedefleme sisteminizi (örneğin, `ox_target` veya `qb-target`) kullanın.
*   "ATM Soy" (veya yerelleştirilmiş metniniz) seçeneği görünmelidir.
*   Seçildiğinde, mini oyun başlayacaktır (minimum polis sayısı ve bekleme süreleri gibi tüm koşullar karşılanırsa).
*   Mini oyunu başarıyla tamamlamak rastgele bir ödül verecektir. Başarısızlık, eşyayı tüketecek ve daha kısa bir ATM bekleme süresini (veya `Config.RemoveCooldownOnFail` ayarına bağlı olarak hiçbiri) tetikleyebilir. 