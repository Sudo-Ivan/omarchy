# Need gum to query for input
if ! command -v gum &> /dev/null
then
    yay -S --noconfirm --needed gum
fi

# Configure identification
if [[ -z "${OMARCHY_USER_NAME//[[:space:]]/}${OMARCHY_USER_EMAIL//[[:space:]]/}" ]]; then
  echo -e "\nEnter identification for git and autocomplete..."
  export OMARCHY_USER_NAME=$(gum input --placeholder "Enter full name" --prompt "Name> ")
  export OMARCHY_USER_EMAIL=$(gum input --placeholder "Enter email address" --prompt "Email> ")
fi
