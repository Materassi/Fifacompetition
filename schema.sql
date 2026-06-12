-- World Cup 2026 Pool — run this once in Supabase → SQL Editor → New query → Run.
-- It creates one key/value table that holds players, predictions, results, and config.

create table if not exists kv (
  key        text primary key,
  value      jsonb not null,
  updated_at timestamptz default now()
);

alter table kv enable row level security;

-- Friends-pool access: anyone with the public anon key can read/write.
-- (Same trust level as a shared link. To tighten later, replace these with
--  authenticated policies — ask and I'll provide them.)
drop policy if exists kv_read   on kv;
drop policy if exists kv_insert on kv;
drop policy if exists kv_update on kv;
drop policy if exists kv_delete on kv;

create policy kv_read   on kv for select using (true);
create policy kv_insert on kv for insert with check (true);
create policy kv_update on kv for update using (true) with check (true);
create policy kv_delete on kv for delete using (true);
