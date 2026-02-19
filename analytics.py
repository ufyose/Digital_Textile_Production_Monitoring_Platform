import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import os

# 1. Veriyi Yükleme
csv_yolu = 'örnek_data.csv'

if not os.path.exists(csv_yolu):
    print(f"Hata: '{csv_yolu}' dosyası bulunamadı!")
else:
    df = pd.read_csv(csv_yolu)

    # Birim Satış Fiyatı (SALES tablosundaki Revenue mantığına uygun)
    birim_satis_fiyati = 180  # TL

    # Mevcut Gelir Hesaplaması
    df['Gelir'] = df['Satis_Adet'] * birim_satis_fiyati

    # 2. Gelecek Tahminlemesi (Temmuz - Aralık)
    # Üretim trendini hesaplıyoruz
    ortalama_artis = df['Uretim_Adet'].pct_change().mean()
    gelecek_aylar = ['Temmuz', 'Ağustos', 'Eylül', 'Ekim', 'Kasım', 'Aralık']

    tahmin_listesi = []
    son_uretim = df['Uretim_Adet'].iloc[-1]
    son_satis = df['Satis_Adet'].iloc[-1]

    for ay in gelecek_aylar:
        son_uretim *= (1 + ortalama_artis)
        son_satis *= (1 + ortalama_artis)
        
        gelir = int(son_satis) * birim_satis_fiyati
        
        tahmin_listesi.append({
            'Ay': ay, 
            'Uretim_Adet': int(son_uretim), 
            'Satis_Adet': int(son_satis), 
            'Gelir': gelir
        })

    df_tahmin = pd.DataFrame(tahmin_listesi)
    df_final = pd.concat([df, df_tahmin]).reset_index(drop=True)

    # 3. Görselleştirme (Üretim vs Gelir)
    plt.figure(figsize=(12, 6))
    plt.style.use('ggplot')

    # Üretim Miktarı (Bar)
    plt.bar(df_final['Ay'], df_final['Uretim_Adet'], color='royalblue', alpha=0.5, label='Üretim Miktarı (Adet)')
    
    # Gelir Trendi (Çizgi)
    # Gelir rakamları büyük olduğu için sağ tarafta farklı bir eksen de kullanılabilir 
    # ama görsel basitlik için aynı grafikte trend olarak gösteriyoruz.
    plt.plot(df_final['Ay'], df_final['Uretim_Adet'], color='darkblue', marker='o', label='Üretim Trendi')

    plt.axvline(x=5.5, color='red', linestyle='--', label='Gelecek Dönem Tahmini')
    plt.title('Tekstil Üretim Hattı: Kapasite ve Performans Analizi', fontsize=14)
    plt.xlabel('Aylar')
    plt.ylabel('Miktar / Adet')
    plt.legend()
    
    plt.tight_layout()
    plt.savefig('uretim_analizi.png')
    print("Analiz grafiği 'uretim_analizi.png' olarak kaydedildi.")
    plt.show()

    # Özet Rapor
    print(f"\n--- 2026 Yıl Sonu Performans Tahmini ---")
    print(f"Toplam Tahmini Üretim: {df_final['Uretim_Adet'].sum()} Adet")
    print(f"Toplam Tahmini Brüt Gelir: {df_final['Gelir'].sum():,.2f} TL")