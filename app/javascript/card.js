const pay = () => {
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);
  const form = document.getElementById("donation-form");
  form.addEventListener("submit", (e) => {
    e.preventDefault();
 
    const formResult = document.getElementById("donation-form");
    const formData = new FormData(formResult);
 
    const card = {
      number: formData.get("card_number"),
      cvc: formData.get("cvc"),
      exp_month: formData.get("exp_month"),
      exp_year: `20${formData.get("exp_year")}`,
    };

    function CardDisabled() {
      const donation_btn = document.getElementById("donation_btn");
      donation_btn.disabled = false;
    }

    Payjp.createToken(card, (status, response) => {
      if (status === 200) {
        const token = response.id;
        const renderDom = document.getElementById("donation-form");
        const donation_btn = document.getElementById("donation_btn");
        const tokenObj = `<input value=${token} type="hidden" name='user_donation[token]'>`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
 
        document.getElementById("card-number").removeAttribute("name");
        document.getElementById("card-cvc").removeAttribute("name");
        document.getElementById("card-exp-month").removeAttribute("name");
        document.getElementById("card-exp-year").removeAttribute("name");
 
        document.getElementById("donation-form").submit();
        document.getElementById("donation-form").reset();
        CardDisabled()
      } else {
        CardDisabled()
        alert("カード登録に失敗しました")
      }
    });
  });
 };
 
 window.addEventListener("load", pay);