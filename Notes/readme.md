# Notes

<https://search.nixos.org/packages>

- shows a mix of HM and non HM. Also shows global cfg

<https://github.com/nmasur/dotfiles/blob/b282e76be4606d9f2fecc06d2dc8e58d5e3514be/flake.nix>

## Edge Setup

- Wizard begins
    - `get started`
    - `focused`
    - `confirm`
    - `sign in to sync data`
    - sync browser data accross: `yes`
    - `confimrm`
- All extentions will start syncing
- Close all tabs
- Go to `settings`
    - Ensure the following are set (will remove ones synced later):
        - Profiles > Microsoft Rewards: Toggle `off`
        - Profiles > Profle Preferences: Allow single sign-on: `yes`
        - Privacy, search, and services:
            - Tracking Prevention `Balanced`
            - Send "Do not track" `on`
            - Services:
                - `off`
                    - Suggest similar sites
                    - Save time and money
                    - Show suggestions to follow
                    - Get notifications
                - Address bar and search:
                    - Search engine used: `google`
                    - Search on new tabs: `address bar`
        - Appearance
            - Overall: `gtk`
            - Customise Tool Bar:
                - Show tab action menu: `off`
                - > buttons on toolbar:
                    - all `off` but collections
                - Show Workspaces: `off`
            - Context menu:
                - How smart actions: `off`
        - Side bar > copilot:
            - SHow copilot: `off`
                - This hides the entire sidebar
    - start, home and new tabs:
        - show home button on toolbar: `off`
        - Open these pages: `google`
    - system & performance:
        - Efficiency mode: `on`
        - Save resources sleeping tabs: `on`
        - Fade sleeping: `on`
- Login to everything

