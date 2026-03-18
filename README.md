# 📈 Pure CSS Financial Terminal Dashboard

這是一個挑戰「零 JavaScript」極限的前端實驗專案。我們僅透過純粹的 HTML5 與 CSS3，打造出一個具備路由切換、複雜網格佈局與數據視覺化效果的賽博龐克風（Cyberpunk / Bloomberg Terminal）金融儀表板。

## ✨ 核心技術亮點 (Core Concepts)

* **Zero JS Routing (零腳本路由)：** 利用「Radio Button Hack (單選框駭客技巧)」結合 CSS 兄弟選擇器 (`~`)，實現無縫的單頁應用程式 (SPA) 分頁切換。
* **CSS Grid & Flexbox：** 構建高彈性、響應式的複雜數據區塊排版。
* **Pure CSS Visualizations (純 CSS 數據視覺化)：** 不依賴任何圖表庫 (如 Chart.js 或 D3.js)，純粹使用 CSS 繪製長條圖與圓餅圖。

---

## 🗂️ 子頁面設計架構 (Sub-pages Architecture)

本終端機包含三個主要子頁面，透過左側導覽列無縫切換：

### 1. 🇺🇸 頁面一：大盤與美股監控 (US Stocks & Global Overview)
這是資訊密度最高的主畫板，專注於市場宏觀數據。
* **即時跑馬燈 (Top Ticker)：** 利用 `@keyframes` 動畫，實現 S&P 500、Nasdaq 等指數的無限水平滾動報價。
* **板塊熱力圖 (Sector Heatmap)：** 運用 CSS Grid 切割大小不一的區塊，透過背景色 (深綠/深紅) 視覺化呈現各科技股或金融股的漲跌幅度。
* **迷你走勢圖 (Mini Sparklines)：** 利用 Flexbox 堆疊不同高度的 `<div>` 柱狀體，配合 `:hover` 放大效果，模擬個股近期的價格走勢。

### 2. 🪙 頁面二：加密貨幣資產 (Crypto Watchlist)
專注於高波動市場，視覺風格帶有強烈的霓虹科技感。
* **動態資產卡片 (Asset Cards)：** 顯示 BTC、ETH 等標的。當游標懸停 (`:hover`) 時，觸發 `box-shadow` 產生專屬的霓虹光暈，並帶有 `translateY` 的平滑浮起效果。
* **資產配置圓餅圖 (Donut Chart)：** 捨棄 SVG，利用 CSS 的 `conic-gradient` (圓錐漸層) 與 `mask` (遮罩) 屬性，繪製出帶有中空效果的純 CSS 圓環圖，展示投資比例。

### 3. 📰 頁面三：國際財經新聞 (International News Feed)
文字主導的訊息流，強調整齊的排版與互動性。
* **純 CSS 時間軸 (Timeline View)：** 利用偽元素 (`::before`, `::after`) 在左側繪製垂直引導線與時間節點。
* **折疊面板 (News Accordion)：** 運用「Checkbox Hack」，讓新聞列表預設隱藏內文，點擊標題即可平滑展開或收合詳細內容，全程無需編寫任何折疊邏輯的腳本。

---

## 🚀 快速開始 (Getting Started)

1. 將本專案 clone 或下載至本地端。
2. 確保 `index.html` 與 `style.css` 位於同一目錄下。
3. 直接使用任何現代瀏覽器 (Chrome, Edge, Firefox, Safari) 開啟 `index.html` 即可體驗。

## 🛠️ 開發與維護 (Development)

* `index.html`: 負責所有結構與路由狀態紀錄 (Hidden Radios)。
* `style.css`: 掌管所有的魔法，包含顏色變數 (`:root`)、排版引擎與動畫關鍵影格。

---

## 📤 推送到 GitHub

1. **安裝 Git**（若尚未安裝）：至 [git-scm.com](https://git-scm.com/) 下載，安裝後重新開啟終端機。
2. **在 GitHub 建立新儲存庫**：登入 GitHub → **New repository** → 取名（例如 `pure-css-financial-dashboard`）→ 不要勾選加入 README（本機已有）→ **Create repository**。
3. **在本機專案資料夾執行**（將 `YOUR_USER` / `YOUR_REPO` 改成你的帳號與儲存庫名稱）：

```bash
cd "專案資料夾路徑"
git init
git add .
git commit -m "feat: pure CSS financial terminal dashboard"
git branch -M main
git remote add origin https://github.com/YOUR_USER/YOUR_REPO.git
git push -u origin main
```

4. **（選用）GitHub Pages 靜態網頁**：儲存庫 → **Settings** → **Pages** → **Source** 選 **Deploy from a branch** → Branch 選 `main`、資料夾 `/ (root)` → Save。數分鐘後可透過 `https://YOUR_USER.github.io/YOUR_REPO/` 開啟（若儲存庫為專案站，網址規則以 GitHub 顯示為準）。

若已使用 **SSH**，將 `remote` 改為 `git@github.com:YOUR_USER/YOUR_REPO.git` 即可。