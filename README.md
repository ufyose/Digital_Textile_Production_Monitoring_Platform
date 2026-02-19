Digital Textile Production & Monitoring Platform
Bu proje, bir tekstil fabrikasındaki üretim süreçlerini (tasarımdan son satışa kadar) dijital olarak takip edebilmek için geliştirdiğim bir sistem tasarımı ve veritabanı mimarisi çalışmasıdır. Amacım, üretimin her aşamasında verinin kaybolmamasını ve tüm sürecin belirli bir mantık çerçevesinde izlenebilir olmasını sağlamaktır.
+2

💡 Neyi Çözmeye Çalıştım?
Tekstil üretimi; tasarım, dikim, ütüleme ve kalite kontrol gibi çok fazla aşamadan oluşur. Bu süreçleri kağıt üzerinde veya dağınık tablolarda takip etmek hata riskini artırır. Bu projede, veriyi birbirine bağlayarak her ürünün o an hangi aşamada olduğunu, ne kadarının onaylandığını ve satışa hazır hale geldiğini gerçek zamanlı görebilmeyi hedefledim.
+3

🏗️ Nasıl Tasarladım? (3-Tier Architecture)
Sistemi, modern yazılım standartlarına uygun olarak üç ana parçaya (katmana) ayırarak kurguladım:


Arayüz (Presentation): Ofiste sipariş yönetenler için masaüstü, üretim sahasında veri giren çalışanlar için ise mobil uygulama odaklı bir yapı planladım.
+1


İş Mantığı (Application): Sistemin "kurallarını" belirleyen katman. Örneğin; bir ürünün tasarımı bitmeden üretimine başlanamaz veya kalite kontrolü geçemeyen ürün satışa sunulamaz.
+1


Veritabanı (Data): Tüm bilgilerin MySQL üzerinde güvenli, düzenli ve hızlı bir şekilde saklandığı katman.
+1

📑 Veritabanı Mantığı ve Normalizasyon (3NF)
Veritabanını tasarlarken verinin tekrar etmemesi ve hatalı girilmemesi için 3. Normal Form (3NF) kurallarını uyguladım:
+1


Gereksiz Veri Tekrarını Sildim: Müşteri bilgilerini her ürüne ayrı ayrı yazmak yerine sipariş tablosuna bağladım.
+2


Bağımsızlık Sağladım: Tasarımcı bilgilerini ve kumaş detaylarını ayrı bir tabloda tutarak sistemin daha esnek ve tutarlı çalışmasını sağladım.
+2

📋 Kritik İş Kuralları (Business Rules)
Veritabanının hatalı veriyi reddetmesi ve iş akışının bozulmaması için şu kuralları temel aldım:

İş Akış Sıralaması: Bir ürünün tasarımı tamamlanmadan üretimine geçilemez; üretim ise mutlaka Dikim -> Ütüleme -> Kalite Kontrol sırasını takip etmelidir.


Otomatik Hesaplama: Onaylı ürün miktarı, toplam miktardan hatalı miktar çıkarılarak sistem tarafından otomatik olarak hesaplanır (Approved = Total - Defective).
+1


Hata Denetimi: Girilen hatalı (defective) ürün sayısı, toplam üretilen sayıdan hiçbir zaman fazla olamaz.


Satış Kısıtlaması: Sadece kalite kontrolü başarıyla geçen (Approved > 0) ürünlerin satışı yapılabilir.


Tarih Mantığı: Tasarım, üretim ve satış tarihleri mutlaka birbirini mantıksal bir sıra ile takip etmelidir.

📂 Dosya Yapısı
database_schema.sql: Tüm tablo yapılarını, ilişkileri ve iş kurallarını içeren MySQL kodu.


Digital-Textile-Production.pdf: Tasarım sürecini, normalizasyon adımlarını ve mimari detayları anlatan detaylı teknik doküman.
+1


ER_Diagram.png: Tablolar arasındaki bağlantıları (PK/FK) gösteren görsel diyagram.
