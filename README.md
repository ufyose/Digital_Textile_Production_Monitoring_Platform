# Digital Textile Production & Monitoring Platform

[cite_start]Bu proje, bir tekstil fabrikasındaki üretim süreçlerini (tasarımdan son satışa kadar) dijital olarak takip edebilmek için geliştirdiğim bir sistem tasarımı ve veritabanı mimarisi çalışmasıdır[cite: 3, 9]. [cite_start]Amacım, üretimin her aşamasında verinin kaybolmamasını ve tüm sürecin belirli bir mantık çerçevesinde izlenebilir olmasını sağlamaktır[cite: 4, 11].

## 💡 Neyi Çözmeye Çalıştım?
[cite_start]Tekstil üretimi; tasarım, dikim, ütüleme ve kalite kontrol gibi çok fazla aşamadan oluşur[cite: 13, 79]. [cite_start]Bu süreçleri kağıt üzerinde veya dağınık tablolarda takip etmek hata riskini artırır [cite: 195-197]. [cite_start]Bu projede, veriyi birbirine bağlayarak her ürünün o an hangi aşamada olduğunu, ne kadarının onaylandığını ve satışa hazır hale geldiğini gerçek zamanlı görebilmeyi hedefledim[cite: 14, 21].



## 🏗️ Nasıl Tasarladım? (3-Tier Architecture)
[cite_start]Sistemi, modern yazılım standartlarına uygun olarak üç ana parçaya (katmana) ayırarak kurguladım [cite: 219-221]:
1. [cite_start]**Sunum Katmanı (Presentation):** Ofiste sipariş yöneten yöneticiler için masaüstü uygulaması ve üretim sahasında veri giren çalışanlar için mobil uygulama odaklı bir yapı planladım [cite: 222-229].
2. [cite_start]**İş Mantığı (Application):** Sistemin "kurallarını" belirleyen ve verinin doğru akmasını sağlayan katman [cite: 230-231]. [cite_start]Örneğin; bir ürünün tasarımı bitmeden üretimine başlanamaz[cite: 232].
3. [cite_start]**Veritabanı (Data):** Tüm bilgilerin MySQL üzerinde güvenli ve düzenli bir şekilde saklandığı, 5 ana tablodan oluşan katman [cite: 236-239].

## 📑 Veritabanı Mantığı ve Normalizasyon (3NF)
Veritabanını tasarlarken verinin tekrar etmemesi ve sorguların hızlı çalışması için **3. [cite_start]Normal Form (3NF)** kurallarını uyguladım [cite: 190-192]:
* [cite_start]**1NF (Birinci Normal Form):** Her hücrede tek bir veri bulunmasını sağlayarak ürün listelerini ayrıştırdım [cite: 193-200].
* [cite_start]**2NF (İkinci Normal Form):** Müşteri bilgilerini her ürüne ayrı ayrı yazmak yerine sipariş tablosuna taşıyarak veri tekrarını sildim [cite: 202-210].
* [cite_start]**3NF (Üçüncü Normal Form):** Tasarımcı ve kumaş detayları gibi bilgileri ayrı bir tabloya (DESIGN) taşıyarak sistemin daha esnek çalışmasını sağladım [cite: 211-218].



## 📋 Kritik İş Kuralları (Business Rules)
[cite_start]Sistemin hatalı veriyi reddetmesi ve iş akışının bozulmaması için şu kuralları temel aldım[cite: 88, 231]:
* [cite_start]**İş Akış Sıralaması:** Üretim mutlaka Dikim -> Ütüleme -> Kalite Kontrol (Finishing) sırasını takip etmelidir[cite: 91, 233].
* [cite_start]**Otomatik Hesaplama:** Onaylı ürün miktarı, toplam miktardan hatalı miktar çıkarılarak sistem tarafından otomatik hesaplanır[cite: 106, 234].
* [cite_start]**Hata Denetimi:** Girilen hatalı (defective) ürün sayısı, toplam üretilen sayıdan hiçbir zaman fazla olamaz[cite: 105].
* [cite_start]**Satış Kısıtlaması:** Sadece kalite kontrolü başarıyla geçen (Approved > 0) ürünlerin satışı yapılabilir [cite: 94-96].
* [cite_start]**Tarih Mantığı:** Tasarım, üretim ve satış tarihleri mutlaka birbirini mantıksal bir sıra ile takip etmelidir [cite: 100-101].

## 📂 Dosya Yapısı
* `database_schema.sql`: Tüm tablo yapılarını, ilişkileri (Primary/Foreign Key) ve kısıtlamaları içeren MySQL kodu.
* [cite_start]`Digital-Textile-Production.pdf`: Tasarım sürecini, normalizasyon adımlarını ve mimari detayları anlatan detaylı teknik doküman[cite: 1].
* [cite_start]`ER_Diagram.png`: Tablolar arasındaki bağlantıları (Crow's Foot Notasyonu) gösteren görsel diyagram[cite: 111].
