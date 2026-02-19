# Digital Textile Production & Monitoring Platform

Bu proje, bir tekstil fabrikasındaki üretim süreçlerini (tasarımdan son satışa kadar) dijital olarak takip edebilmek için geliştirdiğim bir sistem tasarımı ve veritabanı mimarisi çalışmasıdır. Amacım, üretimin her aşamasında verinin kaybolmamasını ve tüm sürecin belirli bir mantık çerçevesinde izlenebilir olmasını sağlamaktır.

## 💡 Neyi Çözmeye Çalıştım?
Tekstil üretimi; tasarım, dikim, ütüleme ve kalite kontrol gibi çok fazla aşamadan oluşur. Bu süreçleri kağıt üzerinde veya dağınık tablolarda takip etmek hata riskini artırır. Bu projede, veriyi birbirine bağlayarak her ürünün o an hangi aşamada olduğunu, ne kadarının onaylandığını ve satışa hazır hale geldiğini gerçek zamanlı görebilmeyi hedefledim.



## 🏗️ Nasıl Tasarladım? (3-Tier Architecture)
Sistemi, modern yazılım standartlarına uygun olarak üç ana parçaya (katmana) ayırarak kurguladım:
1. **Sunum Katmanı (Presentation):** Ofiste sipariş yöneten yöneticiler için masaüstü uygulaması ve üretim sahasında veri giren çalışanlar için mobil uygulama odaklı bir yapı planladım.
2. **İş Mantığı (Application):** Sistemin "kurallarını" belirleyen ve verinin doğru akmasını sağlayan katman. Örneğin; bir ürünün tasarımı bitmeden üretimine başlanamaz.
3. **Veritabanı (Data):** Tüm bilgilerin MySQL üzerinde güvenli ve düzenli bir şekilde saklandığı, 5 ana tablodan oluşan katman.

## 📑 Veritabanı Mantığı ve Normalizasyon (3NF)
Veritabanını tasarlarken verinin tekrar etmemesi ve sorguların hızlı çalışması için **3. Normal Form (3NF)** kurallarını uyguladım:
* **1NF (Birinci Normal Form):** Her hücrede tek bir veri bulunmasını sağlayarak ürün listelerini ayrıştırdım.
* **2NF (İkinci Normal Form):** Müşteri bilgilerini her ürüne ayrı ayrı yazmak yerine sipariş tablosuna taşıyarak veri tekrarını sildim.
* **3NF (Üçüncü Normal Form):** Tasarımcı ve kumaş detayları gibi bilgileri ayrı bir tabloya (DESIGN) taşıyarak sistemin daha esnek çalışmasını sağladım.



## 📋 Kritik İş Kuralları (Business Rules)
Sistemin hatalı veriyi reddetmesi ve iş akışının bozulmaması için şu kuralları temel aldım:
* **İş Akış Sıralaması:** Üretim mutlaka Dikim -> Ütüleme -> Kalite Kontrol (Finishing) sırasını takip etmelidir.
* **Otomatik Hesaplama:** Onaylı ürün miktarı, toplam miktardan hatalı miktar çıkarılarak sistem tarafından otomatik hesaplanır.
* **Hata Denetimi:** Girilen hatalı (defective) ürün sayısı, toplam üretilen sayıdan hiçbir zaman fazla olamaz.
* **Satış Kısıtlaması:** Sadece kalite kontrolü başarıyla geçen (Approved > 0) ürünlerin satışı yapılabilir.
* **Tarih Mantığı:** Tasarım, üretim ve satış tarihleri mutlaka birbirini mantıksal bir sıra ile takip etmelidir.

## 📂 Dosya Yapısı
* `database_schema.sql`: Tüm tablo yapılarını, ilişkileri (Primary/Foreign Key) ve kısıtlamaları içeren MySQL kodu.
* `Digital-Textile-Production.pdf`: Tasarım sürecini, normalizasyon adımlarını ve mimari detayları anlatan detaylı teknik doküman.
* `ER_Diagram.png`: Tablolar arasındaki bağlantıları (Crow's Foot Notasyonu) gösteren görsel diyagram.

  ## 📊 Data Analytics & Capacity Forecasting
Projenin bu aşamasında, veritabanındaki verileri işleyerek işletmeye stratejik öngörüler sunan bir analitik katman ekledim:
* **Tahminleme:** Python (Pandas) kullanarak geçmiş üretim trendleri üzerinden yıl sonu kapasite tahmini yapıldı.
* **Görselleştirme:** Matplotlib ile üretim hacmi ve performans verileri profesyonel grafiklere dönüştürüldü.
* **Veri Yönetimi:** Veriler, sistem güvenliği ve taşınabilirlik adına `örnek_data.csv` dosyası üzerinden dinamik olarak okunmaktadır.


